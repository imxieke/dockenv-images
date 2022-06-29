<!--
 * @Author: Cloudflying
 * @Date: 2022-06-30 00:20:41
 * @LastEditTime: 2022-06-30 00:44:30
 * @LastEditors: Cloudflying
 * @Description:
 * @FilePath: /dockenv/images/mssql/readme.MD
-->

## MSSQL

### How to use this Image
```
docker run -d \
    -e "ACCEPT_EULA=Y" \
    -e "SA_PASSWORD=yourStrong(!)Password" \
    -p 1433:1433 \
    mcr.microsoft.com/mssql/server:latest
```

### Connect to Microsoft SQL Server:
```
docker exec \
    -it <container_id|container_name> \
    /opt/mssql-tools/bin/sqlcmd \
    -S localhost \
    -U sa \
    -P <your_password>
```

## SQL Server Tag lists
- latest
- 2022-latest
- 2019-latest
- 2017-latest

## Requirements
- This image requires Docker Engine 1.8+
- At least 2GB of RAM (3.25 GB prior to 2017-CU2). Make sure to assign enough memory to the Docker VM if you're running on Docker for Mac or Windows.
- Requires the following environment flags
  - `ACCEPT_EULA=Y`
  - `SA_PASSWORD=<your_strong_password>`
  - `MSSQL_PID=<your_product_id | edition_name> (default: Developer)`
- A strong system administrator (SA) password: At least 8 characters including uppercase, lowercase letters, base-10 digits and/or non-alphanumeric symbols.
