# Inception - 42 Project

## Description

This project involves setting up a small infrastructure composed of different services using Docker Compose. The infrastructure includes:

- **NGINX** with TLS/SSL (TLSv1.2 or TLSv1.3 only)
- **WordPress** with php-fpm
- **MariaDB** database
- **Docker volumes** for persistent data storage
- **Custom Docker network** for container communication

## Architecture

```
Internet → NGINX (443/HTTPS) → WordPress (php-fpm) → MariaDB
```

## Prerequisites

- Docker
- Docker Compose
- Make

## Quick Start

### 1. Clone and Setup

```bash
git clone <your-repo>
cd inc_git
```

### 2. Configure Domain

Add the following line to your `/etc/hosts` file:

```
127.0.0.1 matprod.42.fr
```

### 3. Build and Run

```bash
make all
```

This will:

- Create necessary directories
- Build Docker images
- Start all services

### 4. Access the Application

- **Website**: https://matprod.42.fr
- **WordPress Admin**: https://matprod.42.fr/wp-admin
  - Username: `superuser`
  - Password: `adminpassword123`

## Available Commands

| Command        | Description                               |
| -------------- | ----------------------------------------- |
| `make all`     | Setup, build and start all services       |
| `make build`   | Build Docker images                       |
| `make up`      | Start all containers                      |
| `make down`    | Stop all containers                       |
| `make restart` | Restart all containers                    |
| `make logs`    | Show logs for all services                |
| `make clean`   | Stop containers and clean up              |
| `make fclean`  | Remove everything (images, volumes, data) |
| `make re`      | Full rebuild                              |
| `make status`  | Show container status                     |
| `make help`    | Show help message                         |

## Project Structure

```
inc_git/
├── Makefile                 # Build and deployment commands
├── README.md               # This file
├── srcs/
│   ├── .env                # Environment variables
│   ├── docker-compose.yml  # Docker Compose configuration
│   └── requirements/
│       ├── nginx/          # NGINX configuration
│       ├── wordpress/      # WordPress configuration
│       ├── mariadb/        # MariaDB configuration
│       └── tools/          # Utility scripts
└── secrets/                # Credentials (not in git)
```

## Services Details

### NGINX

- **Port**: 443 (HTTPS only)
- **SSL/TLS**: TLSv1.2 and TLSv1.3
- **Features**: SSL termination, reverse proxy, static file serving
- **Configuration**: `/srcs/requirements/nginx/conf/`

### WordPress

- **Service**: php-fpm
- **Features**: WordPress CMS with custom configuration
- **Database**: Connected to MariaDB
- **Configuration**: `/srcs/requirements/wordpress/conf/`

### MariaDB

- **Port**: 3306 (internal only)
- **Features**: WordPress database, user management
- **Configuration**: `/srcs/requirements/mariadb/conf/`

## Security Features

- SSL/TLS encryption
- Security headers
- File permission restrictions
- Database user separation
- No sensitive data in Dockerfiles

## Troubleshooting

### Container Won't Start

```bash
make logs          # Check logs
make status        # Check container status
docker ps -a       # List all containers
```

### Permission Issues

```bash
sudo chown -R $USER:$USER /home/$USER/data
chmod -R 755 /home/$USER/data
```

### SSL Certificate Issues

```bash
make fclean        # Clean everything
make all          # Rebuild from scratch
```

## Development

### Adding New Services

1. Create service directory in `srcs/requirements/`
2. Add Dockerfile and configuration
3. Update `docker-compose.yml`
4. Update Makefile if needed

### Customizing Configuration

- Edit files in `srcs/requirements/{service}/conf/`
- Rebuild with `make build`
- Restart with `make restart`

## Notes

- All containers restart automatically on crash
- Data persistence through Docker volumes
- Network isolation between containers
- No `latest` tags used (security best practice)
- Environment variables for all sensitive data

## Author

**matprod** - 42 Student

## License

This project is part of the 42 curriculum.
