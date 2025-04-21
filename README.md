# Docker Compose for Multiple WordPress Sites

This project provides a Docker Compose setup to run isolated PHP applications, specifically configured for WordPress, using Nginx and PHP-FPM. It allows running multiple instances of the setup on different ports by leveraging environment variables.

## Project Structure

- `compose.yml`: Defines the Docker services (`nginx`, `php`), network (`wordpress-network`), and volumes.
- `nginx/`: Contains Nginx configuration files.
  - `site.conf`: The Nginx site configuration, mounted into the `nginx` container.
- `wp/`: This directory should contain your WordPress core files. It's mounted into both `nginx` and `php` containers.
- `logs/`: Stores Nginx logs.
- `Makefile`: Provides convenient shortcuts for Docker Compose commands.
- `.env` (You need to create this): Used to store environment variables for configuration.

## Configuration

This setup relies on environment variables for configuration. Create a `.env` file in the project root with the following variables:

```dotenv
# Unique identifier for this site instance (used in container names)
SITE_NAME=mysite1

# Port on the host machine to map to Nginx port 80
NGINX_HOST_PORT=8001

# WordPress Database Configuration (replace with your actual details)
# Assumes you have an external database (e.g., cloud-based or another container)
WORDPRESS_DB_HOST=your_database_host
WORDPRESS_DB_USER=your_database_user
WORDPRESS_DB_PASSWORD=your_database_password
WORDPRESS_DB_NAME=your_database_name
```

- `SITE_NAME`: A unique name for this site instance. This helps differentiate container names if you run multiple instances.
- `NGINX_HOST_PORT`: The port on your host machine that will forward to the Nginx container's port 80. Choose a unique port for each site instance.
- `WORDPRESS_DB_*`: Connection details for your WordPress database. This setup **does not** include a database container; you need to provide connection details for an existing database.

## Setup

1.  **Clone the repository:**
    ```bash
    git clone <repository-url>
    cd <repository-directory>
    ```
2.  **Create `.env` file:** Create the `.env` file in the project root and add the necessary environment variables as described in the **Configuration** section.
3.  **Add WordPress files:** Download the WordPress core files and place them in the `./wp` directory.
4.  **Configure Nginx:** Modify `./nginx/site.conf` if needed for your specific WordPress setup (e.g., permalinks). The default configuration should work for basic WordPress installations.
5.  **Start the containers:**
    ```bash
    make d-up
    # or
    docker compose up -d
    ```

Your WordPress site should now be accessible at `http://localhost:<NGINX_HOST_PORT>`.

## Usage

The `Makefile` provides shortcuts for common commands:

- `make d-up`: Start the containers in detached mode.
- `make d-stop`: Stop the running containers.
- `make d-down`: Stop and remove the containers, network, and volumes (defined in `compose.yml`).
- `make d-restart`: Restart the containers.
- `make d-logs`: Follow the logs from the containers.

## Running Multiple Sites

To run another isolated WordPress site:

1.  Copy the entire project directory to a new location.
2.  Navigate to the new directory.
3.  Modify the `.env` file in the new directory, ensuring you set a **unique** `SITE_NAME` and a **different** `NGINX_HOST_PORT`.
4.  Place the WordPress files for the second site in its `./wp` directory.
5.  Run `make d-up` in the new directory.

You can now access the second site at `http://localhost:<new_NGINX_HOST_PORT>`. Repeat this process for additional sites.
