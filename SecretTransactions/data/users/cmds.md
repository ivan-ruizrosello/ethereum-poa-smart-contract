# LOCAL

Alice va a encriptar el documento para compartirlo con Bob

## DOCUMENTO

Este texto sera el mensaje a enviar

`GeeksHubsBlockchainValencia`

## Hash

creamos un hash del documento.

`echo -n GeeksHubsBlockchainValencia | sha256sum`

Resultado hash (actuara como ID del documento): `244de5e246a6371ca7b2ada1fc2f9c299e8477a92e6719f987888e7e0643aa04`

## Alice firma

Firmamos el documento desde el nodo de Alice

COMANDO: `curl --data-binary '{"jsonrpc": "2.0", "method": "secretstore_signRawHash", "params": ["0xcf13c2a66e2d99696ef5d8cb9e835b5e6d83c1c8", "alicepassword", "0x244de5e246a6371ca7b2ada1fc2f9c299e8477a92e6719f987888e7e0643aa04"], "id":1 }' -H 'content-type: application/json' http://127.0.0.1:8545/`

RESULTADO FIRMADO: `{"jsonrpc":"2.0","result":"0x4e37e6dde3653e1430d5c99070c532a10ae4f06eafe96c49c9c535b5a32d907e53bf2a885013190601ef3c5ddeef589d3f7b35afc58c3915bac8e75ba6cb2b0000","id":1}`

## Objeter clave del servidor

`curl -X POST http://localhost:8010/shadow/244de5e246a6371ca7b2ada1fc2f9c299e8477a92e6719f987888e7e0643aa04/4e37e6dde3653e1430d5c99070c532a10ae4f06eafe96c49c9c535b5a32d907e53bf2a885013190601ef3c5ddeef589d3f7b35afc58c3915bac8e75ba6cb2b0000/1`

resultado (parte publica de la clave del servidor para este documento): `"0x68e637980531d45012729fd0895af8ab27745cf13abaacd20472823402d201eb071b258d4f3da5266ed8d70339bfdb93954692d7717b06305e4cd7e518dcb9b0"`

## Clave del documento

comando: `curl --data-binary '{"jsonrpc": "2.0", "method": "secretstore_generateDocumentKey", "params": ["0xcf13c2a66e2d99696ef5d8cb9e835b5e6d83c1c8", "alicepassword","0x68e637980531d45012729fd0895af8ab27745cf13abaacd20472823402d201eb071b258d4f3da5266ed8d70339bfdb93954692d7717b06305e4cd7e518dcb9b0"], "id":1 }' -H 'content-type: application/json' http://127.0.0.1:8545/`

resultado (clave encriptada que usaremos para encriptar el documento offline, ademas devuelve la tupla, punto comun y un punto encriptado): `{"jsonrpc":"2.0","result":{"common_point":"0x3d0c02c9b1ab34e49093a0e1fea6225b31d019582fc5dbea3f845ec0986ba953e7e36f7876a8ce9dfe6058ef47039dde51e35db05b7f99bf4aecb291cf84abb1","encrypted_key":"0x04ffa52d5d1545bcdd4d7e955cac36e597e87a78a0637a71f7b26a9de63bb2439bf65200176025a0d598dc1b6cc40672ac06e6c3aca262afe19d79a02bd497af81b12c02124e12d94312749c85d0dd058f3282588c2b9b0792ee4332885decafbd28530aefde4aba058932e23b6ed87e564ea546e1dfeabd23adda91d9721a96a1b47ae538ea57516f5cf86a0b17b5e932f07aff4b0d34d9113c6c603744ea0e4fecdc5e9db3b92b0e9e4e758b9d5725b0","encrypted_point":"0x4c568e265284b272f913384f782f2afb52523e4309cba2106b0a0f2e5a13ed9fd0ebe252ce7a1b61dc1961a915a3265f5885a1e9da28a922793d4a5aa8d79126"},"id":1}`

## Pasamos el documento a exadecimal

Para poder encriptarlo hay que pasarlo a exadecimal.

comando: `echo -n GeeksHubsBlockchainValencia | xxd -p`

resultado: `4765656b7348756273426c6f636b636861696e56616c656e636961`

resultado con 0x: `0x4765656b7348756273426c6f636b636861696e56616c656e636961`

# ONLINE

## Encriptamos documento

Comando: `curl --data-binary '{"jsonrpc": "2.0", "method": "secretstore_encrypt", "params": ["0xcf13c2a66e2d99696ef5d8cb9e835b5e6d83c1c8", "alicepassword", "0x04ffa52d5d1545bcdd4d7e955cac36e597e87a78a0637a71f7b26a9de63bb2439bf65200176025a0d598dc1b6cc40672ac06e6c3aca262afe19d79a02bd497af81b12c02124e12d94312749c85d0dd058f3282588c2b9b0792ee4332885decafbd28530aefde4aba058932e23b6ed87e564ea546e1dfeabd23adda91d9721a96a1b47ae538ea57516f5cf86a0b17b5e932f07aff4b0d34d9113c6c603744ea0e4fecdc5e9db3b92b0e9e4e758b9d5725b0", "0x4765656b7348756273426c6f636b636861696e56616c656e636961"], "id":1 }' -H 'content-type: application/json' http://127.0.0.1:8545/`

Resultado: `{"jsonrpc":"2.0","result":"0x9f00aa26b7568133fbd3a38a341e8bb82855d9f2c915de65f0949a9048e45a9693dbe50f19fe63dcdfd49b","id":1}`

## Informar al Secret Store

Comando: `curl -X POST http://localhost:8010/shadow/244de5e246a6371ca7b2ada1fc2f9c299e8477a92e6719f987888e7e0643aa04/4e37e6dde3653e1430d5c99070c532a10ae4f06eafe96c49c9c535b5a32d907e53bf2a885013190601ef3c5ddeef589d3f7b35afc58c3915bac8e75ba6cb2b0000/3d0c02c9b1ab34e49093a0e1fea6225b31d019582fc5dbea3f845ec0986ba953e7e36f7876a8ce9dfe6058ef47039dde51e35db05b7f99bf4aecb291cf84abb1/4c568e265284b272f913384f782f2afb52523e4309cba2106b0a0f2e5a13ed9fd0ebe252ce7a1b61dc1961a915a3265f5885a1e9da28a922793d4a5aa8d79126`


Resultado: En los logs de ls nodos debe de aparecer `encryption session completed`

############
# PARA BOB #
############

`0x9f00aa26b7568133fbd3a38a341e8bb82855d9f2c915de65f0949a9048e45a9693dbe50f19fe63dcdfd49b` -> Documento encriptado
`0x244de5e246a6371ca7b2ada1fc2f9c299e8477a92e6719f987888e7e0643aa04` -> ID de la clave de documento

## Firma de bob de la id de la clave del documento

comando: `curl --data-binary '{"jsonrpc": "2.0", "method": "secretstore_signRawHash", "params": ["0x36dfacb13c4985a1de236b57394d4b3745eee507", "bobpassword", "0x244de5e246a6371ca7b2ada1fc2f9c299e8477a92e6719f987888e7e0643aa04"], "id":1 }' -H 'content-type: application/json' http://127.0.0.1:8545/`

resultado: `{"jsonrpc":"2.0","result":"0xf9cf9a361124d554a8c9bd5da467c505241424831932cc795fb35af1ab61b92c724e419c4b1489c5c095a54452cb4b17c5de9c1354618863614de60cb4b39a9800","id":1}`

## Obtenemos la informacion necesaria para desencriptar el documento

Comando: `curl http://localhost:8010/shadow/244de5e246a6371ca7b2ada1fc2f9c299e8477a92e6719f987888e7e0643aa04/f9cf9a361124d554a8c9bd5da467c505241424831932cc795fb35af1ab61b92c724e419c4b1489c5c095a54452cb4b17c5de9c1354618863614de60cb4b39a9800`

resultado: `{"decrypted_secret":"0x03b290a1f0e85bb7e1b7526cd63843880f7222f5dd0e282b00d98f8ee0c970805f4b1952d078de3a1d8de2350c3d71b84e5e7a142f7aef533f29ce5be553b705","common_point":"0x3d0c02c9b1ab34e49093a0e1fea6225b31d019582fc5dbea3f845ec0986ba953181c908789573162019fa710b8fc6221ae1ca24fa4806640b5134d6d307b507e","decrypt_shadows":["0x04a8ca5d825976627f2cd8c34749a318d596375ade1c025585d38d168823fa2623a59a9ddbd85e9a799859d2a6bbc8ab4600b74181ad6f36d8137965fb3b34a588560eb5c77ff16dde011629069607e7491a1c759ac642ca4d746784f3e9cb078a2b451cc1955f1c9489b6969cacca9f4c0d56b57294d4e26aae7f74b1d814491c7129e83f53cf16b78c65189c7542126e","0x04f4a59872fa8a742f7ffbcbacfe33a8a37857e3ccf03908fdfc8bc3c0c94665c89673684d4c557a0bd3fd6516e38446b596f3b9b4f768d585e3a0af36b4c8f9b785106b204c1843418b85ab6b7618d25b089962c065ff4ea142a5b7479e1a5c4e276951c4f1aeb69420aaf745f7034fde21f63d40bcbc2cbf18b426a5faba270ff6ac5ee1113f0ea830183305d1d244fa"]}`

## Obteniendo el secreto descifrado:

comando: `curl --data-binary '{"jsonrpc": "2.0", "method": "secretstore_shadowDecrypt", "params": ["0x36dfacb13c4985a1de236b57394d4b3745eee507", "bobpassword", "0x03b290a1f0e85bb7e1b7526cd63843880f7222f5dd0e282b00d98f8ee0c970805f4b1952d078de3a1d8de2350c3d71b84e5e7a142f7aef533f29ce5be553b705", "0x3d0c02c9b1ab34e49093a0e1fea6225b31d019582fc5dbea3f845ec0986ba953181c908789573162019fa710b8fc6221ae1ca24fa4806640b5134d6d307b507e", ["0x04a8ca5d825976627f2cd8c34749a318d596375ade1c025585d38d168823fa2623a59a9ddbd85e9a799859d2a6bbc8ab4600b74181ad6f36d8137965fb3b34a588560eb5c77ff16dde011629069607e7491a1c759ac642ca4d746784f3e9cb078a2b451cc1955f1c9489b6969cacca9f4c0d56b57294d4e26aae7f74b1d814491c7129e83f53cf16b78c65189c7542126e","0x04f4a59872fa8a742f7ffbcbacfe33a8a37857e3ccf03908fdfc8bc3c0c94665c89673684d4c557a0bd3fd6516e38446b596f3b9b4f768d585e3a0af36b4c8f9b785106b204c1843418b85ab6b7618d25b089962c065ff4ea142a5b7479e1a5c4e276951c4f1aeb69420aaf745f7034fde21f63d40bcbc2cbf18b426a5faba270ff6ac5ee1113f0ea830183305d1d244fa"], "0x9f00aa26b7568133fbd3a38a341e8bb82855d9f2c915de65f0949a9048e45a9693dbe50f19fe63dcdfd49b"], "id":1 }' -H 'content-type: application/json' http://127.0.0.1:8545/`

resultado: `{"jsonrpc":"2.0","result":"0x4765656b7348756273426c6f636b636861696e56616c656e636961","id":1}`

## Exadecimal a texto palno POR FIN >:|

comando: `echo 0x4765656b7348756273426c6f636b636861696e56616c656e636961 | xxd -r -p`

resultado: `GeeksHubsBlockchainValencia`



################
# PARA CHARLIE #
################

# Firma del documento 
`curl --data-binary '{"jsonrpc": "2.0", "method": "secretstore_signRawHash", "params": ["0xff00fba2fed4bd871b3f3f3477352cdf9d2ce847", "charliepassword", "0x244de5e246a6371ca7b2ada1fc2f9c299e8477a92e6719f987888e7e0643aa04"], "id":1 }' -H 'content-type: application/json' http://127.0.0.1:8545/`

# Pido la informacion para poder desencriptar el documento.

`curl http://localhost:8010/shadow/244de5e246a6371ca7b2ada1fc2f9c299e8477a92e6719f987888e7e0643aa04/1d9bc1db15843bd4cdf37aa70e6618397433f641eb2ce38f788830fbb9f45d3e7956c434ebb314984dc386b7f3a4a683e3474a337374f989c7d6f52b6c5cfb8601`