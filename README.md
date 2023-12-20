# Postgres External

This repo is an Acorn for connecting external Postgres databases to your Acorn applications through the service interface.

## Usage

The Acorn will prompt the user for the following information:

- Address: The address of the Postgres database, no port.
- Port: The port of the Postgres database.
- adminUsername: The username to connect to the Postgres database.
- adminPassword: The password to connect to the Postgres database.
- databaseName: The name of the database to connect to.
- proto: If any special protocol information is needed.

This information will be rendered into an Acorn service object.

if you run:

```bash
acorn run -n postgres-external ghcr.io/acorn-io/postgres-external:v#.#.#
```

It will require you to login to the Acorn to fill in the information.

```bash
acorn login [APP_NAME]
```

In the above example, `acorn login postgres-external` will prompt you for the information.

## How to use with Neon Tech Postgres

Lets walk through using the this Acorn to connect to a Neon Tech Postgres database.

First, you will need an account on [Neon](https://neon.tech) to create a database. We will be using the free tier for this example.

Once we have signed in, we will create a project called demo, and go with the default "neondb" for the database name. We will also use US East Ohio for the region.

## Launch our example Acorn

Now that we have a database created, we can launch our Acorn.

```bash
acorn run -n postgres-demo ghcr.io/acorn-io/postgres-external/examples:v#.#.#
```

This will prompt us for the following information:

```bash
postgres-demo
STATUS: ENDPOINTS[] HEALTHY[] UPTODATE[] 
STATUS: ENDPOINTS[] HEALTHY[0] UPTODATE[0] waiting for quota allocation; (container: nextcloud): pending; (service: db): pending
STATUS: ENDPOINTS[] HEALTHY[0] UPTODATE[0] (container: nextcloud): waiting for service to be created [db], waiting for service to be ready [db]; (service: db): pending
STATUS: ENDPOINTS[https://postgres-demo-1b8cb199.zvgz4d.on-acorn.io] HEALTHY[0] UPTODATE[0] (container: nextcloud): waiting for service to be created [db], waiting for service to be ready [db]; (service: db): acorn [postgres-demo.db] is not ready

  ## Overview                                                                 
                                                                              
  This will create the service from an existing Postgres server.              
                                                                              
  ## Instructions                                                             
                                                                              
  fill in:                                                                    
                                                                              
  • address: the address of the Postgres server endpoint (redis.example.com)  
  • port: the port of the Postgres server (5432)                              
  • adminPassword: the main password to use to connect to the Postgres server 
  as an admin                                                                 
  • proto: the protocol to use to connect to the Postgres server.             
  • dbName: the name of the database to use                                   


? address ***********************************************
? adminPassword ************
? adminUsername ****
? dbName ******
? port ****
? proto 
STATUS: ENDPOINTS[https://postgres-demo-1b8cb199.zvgz4d.on-acorn.io] HEALTHY[0] UPTODATE[0] "acorn login postgres-demo" required
STATUS: ENDPOINTS[https://postgres-demo-1b8cb199.zvgz4d.on-acorn.io] HEALTHY[0] UPTODATE[0] (container: nextcloud): waiting for service to be created [db], waiting for service to be ready [db]; (service: db): acorn [postgres-demo.db] is not ready
STATUS: ENDPOINTS[https://postgres-demo-1b8cb199.zvgz4d.on-acorn.io] HEALTHY[0] UPTODATE[0] (container: nextcloud): waiting for service to be ready [db]; (service: db): acorn [postgres-demo.db] is not ready
STATUS: ENDPOINTS[https://postgres-demo-1b8cb199.zvgz4d.on-acorn.io] HEALTHY[0] UPTODATE[0] (container: nextcloud): waiting for service to be ready [db]
STATUS: ENDPOINTS[https://postgres-demo-1b8cb199.zvgz4d.on-acorn.io] HEALTHY[0] UPTODATE[0] (container: nextcloud): pending
STATUS: ENDPOINTS[https://postgres-demo-1b8cb199.zvgz4d.on-acorn.io] HEALTHY[0/1] UPTODATE[0] (container: nextcloud): not ready
STATUS: ENDPOINTS[https://postgres-demo-1b8cb199.zvgz4d.on-acorn.io] HEALTHY[0/1] UPTODATE[1] (container: nextcloud): ContainerCreating
STATUS: ENDPOINTS[https://postgres-demo-1b8cb199.zvgz4d.on-acorn.io] HEALTHY[0/1] UPTODATE[1] (container: nextcloud): not ready
┌────────────────────────────────────────────────────────────────────────────────────────────────┐
| STATUS: ENDPOINTS[https://postgres-demo-1b8cb199.zvgz4d.on-acorn.io] HEALTHY[1] UPTODATE[1] OK |
└────────────────────────────────────────────────────────────────────────────────────────────────┘
```

Where Address is the address of the Postgres server, obtained from the connection string in Neon dashboard. It does not include the `postgres://` or `:5432` port information.
The port is `5432` unless otherwise specified.
The adminUsername is obtained from the connection string in Neon dashboard.
The adminPassword is obtained from the connection string in Neon dashboard, it requires clicking the "show password" eye icon.
The proto was left blank in this case.

Once the application comes up and you see the URL, you can click on it to see the application. You will need to set the admin username and password for the Next Cloud instance on first login.

## Cleaning up

Once you have launched the app and are finished with it, you can delete it with:

```bash
acorn rm -af postgres-demo
acorn secrets
NAME                TYPE                                 KEYS                                                                        CREATED
config-lsc6n        credential.acorn.io/postgres         [address adminPassword adminUsername dbName port proto]                     15m ago
acorn secret rm config-lsc6n
```

Then you can remove the database instance from the Neon dashboard.
