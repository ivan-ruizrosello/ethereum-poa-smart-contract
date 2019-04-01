# Secret Store

## Instalar Parity con la opción Secret Store

Es necesario compilar Parity especificando secret store. Para ello necesitamos:

* Instalar rustc, cargo y otras dependencias tal y como explican en https://github.com/paritytech/parity-ethereum/. IMPORTANTE: No instalar rustc/cargo desde apt o similar (me ha dado errores)
Clonamos el repositorio de parity, y cambiamos a la rama de la release deseada, por ejemplo:
```
git clone https://github.com/paritytech/parity-ethereum/
cd parity-ethereum
git checkout stable
```
* Compilamos Parity con la opción secret store (nos crea un ejecutable en ./target/release/parity):
```cargo build --features secretstore --release```

* (Opcional) Para poder acceder a nuestro ejecutable de parity desde cualquier sitio y evitar conflictos con la versión por defecto que probablemente ya tengáis instalada, podéis crear un alias “secret_parity” en vuestro bashrc:
alias secret_parity="~/blockchain/secret_store/parity-ethereum/target/release/parity"

## NOTAS

el nodo se ss1 tiene el http activado para exponer la api del SS al exterior









# APUNTES CARLOS

Instalar rust siguiendo los pasos del modulo12:  "1_build_parity.md"

/home/bootcamp/parity/target/release/parity --config /home/bootcamp/ss/data/users/users.toml account new

/home/bootcamp/parity/target/release/parity --config /home/bootcamp/ss/data/ss/ss1.toml account new
/home/bootcamp/parity/target/release/parity --config /home/bootcamp/ss/data/ss/ss2.toml account new
/home/bootcamp/parity/target/release/parity --config /home/bootcamp/ss/data/ss/ss3.toml account new


luego modificar ss1.toml "self_secret" y poner la direccion que te ha generado "account new" sin el 0x


/home/bootcamp/parity/target/release/parity --config ss1.toml
/home/bootcamp/parity/target/release/parity --config ss2.toml
/home/bootcamp/parity/target/release/parity --config ss3.toml

Copiar el "secretStore" que sale al ejecutar y tb copiar el "PublicNode" y en este cambiar la ip a 127.0.0.1:30301 (el puerto configurado del ss1)

Meter ahora en los 3 ssX.toml los "nodes = ["
en los 3 las 3 direcciones.  boorando el comienzo "enode://"



## Enviar ether entre cuentas 

A alice: 
```curl --data '{"method":"personal_sendTransaction","params":[{"from":"0x00a329c0648769a73afac7f9381e08fb43dbea72","to":"0xcf13c2a66e2d99696ef5d8cb9e835b5e6d83c1c8","data":"0xff","value":"0xfffffffffffffffff"},""],"id":1,"jsonrpc":"2.0"}' -H "Content-Type: application/json" -X POST localhost:8545```

A bob: 
```curl --data '{"method":"personal_sendTransaction","params":[{"from":"0x00a329c0648769a73afac7f9381e08fb43dbea72","to":"0x36dfacb13c4985a1de236b57394d4b3745eee507","data":"0xff","value":"0xfffffffffffffffff"},""],"id":1,"jsonrpc":"2.0"}' -H "Content-Type: application/json" -X POST localhost:8545```