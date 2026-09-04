# On-demand development services

The `dev-services` command manages the central ClamAV and MinIO Compose stack.
The containers do not restart automatically and all published ports bind only
to loopback.

```sh
dev-services up              # start both services
dev-services up minio        # start only MinIO
dev-services up clamav       # start only ClamAV
dev-services status
dev-services logs minio
dev-services down            # stop/remove containers; keep data
```

Endpoints:

- ClamAV: `127.0.0.1:3310`
- MinIO S3 API: `http://127.0.0.1:9000`
- MinIO console: `http://127.0.0.1:9001`

Persistent data lives in the named Docker volumes
`dev-services-clamav-signatures` and `dev-services-minio-data`. The Compose
network is named `dev-services`; another Compose project can declare it as an
external network when it needs to reach these services as `clamav:3310` or
`minio:9000`.

The first ClamAV start downloads its signature database and can take several
minutes. ClamAV also needs considerably more memory than its small service
surface suggests.

MinIO Community's upstream repository was archived in April 2026. This stack
uses the final official prebuilt image, which is suitable for isolated local
development but should not be treated as a maintained production service.
