# Database configuration

The application reads its database settings from environment variables. Do not put real credentials in Java source files or commit a populated `.env` file.

Required variables:

- `DB_URL` — JDBC URL, for example `jdbc:mysql://localhost:3305/hostel`
- `DB_USER` — MySQL username
- `DB_PASSWORD` — MySQL password

## Windows PowerShell

Set these variables for your Windows user (replace the username and password with your own values):

```powershell
[Environment]::SetEnvironmentVariable("DB_URL", "jdbc:mysql://localhost:3305/hostel", "User")
[Environment]::SetEnvironmentVariable("DB_USER", "your_mysql_username", "User")
[Environment]::SetEnvironmentVariable("DB_PASSWORD", "your_new_password", "User")
```

Close and reopen IntelliJ IDEA / your terminal and restart Tomcat so the process receives the updated environment.

## Docker

Pass the variables when starting the container. If MySQL is running on the Windows host, use `host.docker.internal` as the hostname:

```powershell
docker run --rm -p 8080:8080 `
  -e DB_URL="jdbc:mysql://host.docker.internal:3305/hostel" `
  -e DB_USER="your_mysql_username" `
  -e DB_PASSWORD="your_new_password" `
  your-image-name
```

For a database running in another container, use that database container's service name in `DB_URL`.

`.env.example` contains placeholders only. Java's `System.getenv()` does not load a `.env` file automatically; configure the variables in your IDE, operating system, or container runtime.
