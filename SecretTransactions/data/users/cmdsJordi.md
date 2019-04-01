## DOCUMENTO
GeeksHubsBlockchainValencia

## ID DE LA CLAVE DE DOCUMENTO
echo -n GeeksHubsBlockchainValencia | sha256sum
--
sha3: 0x244de5e246a6371ca7b2ada1fc2f9c299e8477a92e6719f987888e7e0643aa04 --> Id de la clave de documento

## FIRMA DE ALICE DE LA ID DE LA CLAVE DEL DOCUMENTO
curl --data-binary '{"jsonrpc": "2.0", "method": "secretstore_signRawHash", "params": ["0x632201c76c171e790418b9bd4b611e45caba5310", "alicepwd", "0x244de5e246a6371ca7b2ada1fc2f9c299e8477a92e6719f987888e7e0643aa04"], "id":1 }' -H 'content-type: application/json' http://127.0.0.1:8545/
aliceaccount-alicepwd-idclavedoc
--
0xf394c6c84adb6639ef7f9cbaab826a3f6b8771de83b4fb13d1f1427e721260c91a74dec5d2776bd7451599dc052e7c9607fa4ee8edbfb1a1be4699589b37cd9700 --> Firma de alice de la id de la clave de documento

## CLAVE DE SERVIDOR
curl -X POST http://localhost:8010/shadow/244de5e246a6371ca7b2ada1fc2f9c299e8477a92e6719f987888e7e0643aa04/f394c6c84adb6639ef7f9cbaab826a3f6b8771de83b4fb13d1f1427e721260c91a74dec5d2776bd7451599dc052e7c9607fa4ee8edbfb1a1be4699589b37cd9700/1
idclavedoc-firmaAliceiddoc
--
//0xe16639148ceecb88e08dd50b9b83b420c26bd54879a6271f4bab21e85011154e9ec7bbb28ed3fcdd2d8c6d991f20784c88828f334f99c72d266fb1890b0e0335 --> Participacion de la clave publica del servidor
0x8c257d1558aa12591a82500564a3214a0cb6d601b0035bd4df6e08a35c167892ff1ad03111005d22a165bcaa13b2322431e5f39b5b4515dfe35dffacaba136cd
## CLAVE DEL DOCUMENTO
curl --data-binary '{"jsonrpc": "2.0", "method": "secretstore_generateDocumentKey", "params": ["0x632201c76c171e790418b9bd4b611e45caba5310", "alicepwd","0x8c257d1558aa12591a82500564a3214a0cb6d601b0035bd4df6e08a35c167892ff1ad03111005d22a165bcaa13b2322431e5f39b5b4515dfe35dffacaba136cd"], "id":1 }' -H 'content-type: application/json' http://127.0.0.1:8545/
aliceacc-alicepwd-clavedeservidor
--
//changes
0x636b925d549cb2bbb2283ec3cfcbdea43b85896bf2291ceb2c111797a9f173e788621469cae1522e3a7cafba32f26096f4db6fef5464ec10ba081b67a70d76e3 --> Punto común
0x2c5541538977c544f4f912b629c52d349d46a6a17c1bf2fb5361355364d8995240c7f9de4c1d1ad11acf522af086d602150e5b80b96706006d22b944f275f7ca --> Punto encriptado
0x0405b40d56feb45e48e9684dfa9ffba8f03122dd0abddf0bffeafbb54d3ec40488cb8f49778b3ce2dfe781bbbc4f5ab19dcaca5500a4686decc7d60cf8de38e31607c3684eae2dda1597903801def6c505c46f12e3e684317b5ccd2c3870748558cff5968039a0b0f202a980a05423d1bbd84734765ffdc07acaf41fb20394a17fe9785244658e9d999fd3901080906b71b5d6a2c1b48b73cd19aaeef32d45f41ba03583cb6626238a338dd88626e377c0 --> Clave encriptacion

## DOCUMENTO HEX ENCODED
echo -n GeeksHubsBlockchainValencia | xxd -p
--
0x4765656b7348756273426c6f636b636861696e56616c656e636961 --> mensaje codificado en hexadecimal

## ENCRIPTACIÓN DEL DOCUMENTO
curl --data-binary '{"jsonrpc": "2.0", "method": "secretstore_encrypt", "params": ["0x632201c76c171e790418b9bd4b611e45caba5310", "alicepwd", "0x0405b40d56feb45e48e9684dfa9ffba8f03122dd0abddf0bffeafbb54d3ec40488cb8f49778b3ce2dfe781bbbc4f5ab19dcaca5500a4686decc7d60cf8de38e31607c3684eae2dda1597903801def6c505c46f12e3e684317b5ccd2c3870748558cff5968039a0b0f202a980a05423d1bbd84734765ffdc07acaf41fb20394a17fe9785244658e9d999fd3901080906b71b5d6a2c1b48b73cd19aaeef32d45f41ba03583cb6626238a338dd88626e377c0", "0x4765656b7348756273426c6f636b636861696e56616c656e636961"], "id":1 }' -H 'content-type: application/json' http://127.0.0.1:8545/
--
aliceacc-alicepwd-claveencriptacion-mensajecodificadohex
0xcc214c39a6252ff1360ebc4e54b820f2d800097f05a35fa1fcaa6fc370ccd9c1e287ddc563d33e83c08a02 --> DOCUMENTO ENCRIPTADO

## INFORMAR A SS
curl -X POST http://localhost:8010/shadow/244de5e246a6371ca7b2ada1fc2f9c299e8477a92e6719f987888e7e0643aa04/f394c6c84adb6639ef7f9cbaab826a3f6b8771de83b4fb13d1f1427e721260c91a74dec5d2776bd7451599dc052e7c9607fa4ee8edbfb1a1be4699589b37cd9700/636b925d549cb2bbb2283ec3cfcbdea43b85896bf2291ceb2c111797a9f173e788621469cae1522e3a7cafba32f26096f4db6fef5464ec10ba081b67a70d76e3/2c5541538977c544f4f912b629c52d349d46a6a17c1bf2fb5361355364d8995240c7f9de4c1d1ad11acf522af086d602150e5b80b96706006d22b944f275f7ca
idclavedoc-firmaalice-puntocomun-puntoencriptado


############
# PARA BOB #
############

0xcc214c39a6252ff1360ebc4e54b820f2d800097f05a35fa1fcaa6fc370ccd9c1e287ddc563d33e83c08a02 --> DOCUMENTO ENCRIPTADO
0x244de5e246a6371ca7b2ada1fc2f9c299e8477a92e6719f987888e7e0643aa04 --> Id /de la clave/ de documento

## FIRMA DE BOB DE LA ID DE LA CLAVE DEL DOCUMENTO

0x1fd9bc66d70bae19bb267e844eb267232fbad302866bcurl --data-binary '{"jsonrpc": "2.0", "method": "secretstore_signRawHash", "params": ["0xbaaa39cdb40f389f7977f216fa9b87a3bf039acd", "bobpwd", "0x244de5e246a6371ca7b2ada1fc2f9c299e8477a92e6719f987888e7e0643aa04"], "id":1 }' -H 'content-type: application/json' http://127.0.0.1:8545/ea3713ac18c029bca1be2285cd2c9334798045e294e257718c8165ce9f0dd7fc4db028a895237716498000 --> Firma de Bob de la Id de la clave de documento

## Obteniendo la informacion necesaria para desencriptar el documento
curl http://localhost:8010/shadow/244de5e246a6371ca7b2ada1fc2f9c299e8477a92e6719f987888e7e0643aa04/1fd9bc66d70bae19bb267e844eb267232fbad302866bea3713ac18c029bca1be2285cd2c9334798045e294e257718c8165ce9f0dd7fc4db028a895237716498000
0x4b8e0141bdd52fe99f928b6e6f5ad85a327a4d094bee98d3191412ca4ed063bbfae0930a545f644f6003863ca6941767a05ad7cef86415de21d147f903b3c1f6 --> Secreto descifrado
0x636b925d549cb2bbb2283ec3cfcbdea43b85896bf2291ceb2c111797a9f173e7779deb96351eadd1c5835045cd0d9f690b249010ab9b13ef45f7e49758f2854c --> Punto comun
{
    0x048f3ec847e29ffe85668432c4e31481e22702edf15a524edddb23ca83a90553d720cfcec71306324245ce1ebfaf44f42ae274141c88c8bed4521599e07fc2d9bc51b1e7f9d946ce46670c48fd4319c4152c3877651169b9da30b7b295e70d67c51c6fd91cc21934fdd5081849853b080aca35f24615dd5ad2c12b2c154ade16c2fdb416fe1599ac9781203eecc67bf1de
    0x0466e9c403b5189b3b2d36fd24fe8b4d7c41bc2afecd022ac4d06ce2b32fb02cc92da2fd021ac803381422dcfc559f36cbef1b2d7073bfacefcd17f3dabff38361ab61e60bc8d94b081d245ff8ad3973621bbcefc2914c692cd53733149777255484acb8e75a0a2bcd532daacc8d328f87cc2585ccff6e44743994792fa2abcae9a726924ed9c9b756c34b94aece50c4b0
} --> Sombras de descifrado

curl --data-binary '{"jsonrpc": "2.0", "method": "secretstore_shadowDecrypt", "params": ["0xbaaa39cdb40f389f7977f216fa9b87a3bf039acd", "bobpwd", "0x4b8e0141bdd52fe99f928b6e6f5ad85a327a4d094bee98d3191412ca4ed063bbfae0930a545f644f6003863ca6941767a05ad7cef86415de21d147f903b3c1f6", "0x636b925d549cb2bbb2283ec3cfcbdea43b85896bf2291ceb2c111797a9f173e7779deb96351eadd1c5835045cd0d9f690b249010ab9b13ef45f7e49758f2854c", ["0x048f3ec847e29ffe85668432c4e31481e22702edf15a524edddb23ca83a90553d720cfcec71306324245ce1ebfaf44f42ae274141c88c8bed4521599e07fc2d9bc51b1e7f9d946ce46670c48fd4319c4152c3877651169b9da30b7b295e70d67c51c6fd91cc21934fdd5081849853b080aca35f24615dd5ad2c12b2c154ade16c2fdb416fe1599ac9781203eecc67bf1de","0x0466e9c403b5189b3b2d36fd24fe8b4d7c41bc2afecd022ac4d06ce2b32fb02cc92da2fd021ac803381422dcfc559f36cbef1b2d7073bfacefcd17f3dabff38361ab61e60bc8d94b081d245ff8ad3973621bbcefc2914c692cd53733149777255484acb8e75a0a2bcd532daacc8d328f87cc2585ccff6e44743994792fa2abcae9a726924ed9c9b756c34b94aece50c4b0"], "0xcc214c39a6252ff1360ebc4e54b820f2d800097f05a35fa1fcaa6fc370ccd9c1e287ddc563d33e83c08a02"], "id":1 }' -H 'content-type: application/json' http://127.0.0.1:8545/
bobaddr-bobpwd-decryptedSecret-commonpoint-decryptshadows-encrypteddocument

0x4765656b7348756273426c6f636b636861696e56616c656e636961 --> SECRETO DESCIFRADO

echo 0x4765656b7348756273426c6f636b636861696e56616c656e636961 | xxd -r -p
GeeksHubsBlockchainValencia 

DONE!



curl --data '{"method":"personal_sendTransaction","params":[{"from":"0x00a329c0648769a73afac7f9381e08fb43dbea72","to":"0x632201c76c171e790418b9bd4b611e45caba5310","data":"0x41cd5add4fd13aedd64521e363ea279923575ff39718065d38bd46f0e6632e8e","value":"0xfffffffffffffffff"},""],"id":1,"jsonrpc":"2.0"}' -H "Content-Type: application/json" -X POST localhost:8545

Permissioning contract: 0x0C55E808CeBf319D8e1FF6d45CF6ca71673caB4d


CHARLIE

0x4dfd3a89067eee62c28ef21450f81d775bb095d40e9b34fbaf3496dfadea7b4e6bb5d37fc97ac2b200ecdb1ba438c5da229a51ef73a7ec9c7329a44fbddb969e00

curl http://localhost:8010/shadow/244de5e246a6371ca7b2ada1fc2f9c299e8477a92e6719f987888e7e0643aa04/4dfd3a89067eee62c28ef21450f81d775bb095d40e9b34fbaf3496dfadea7b4e6bb5d37fc97ac2b200ecdb1ba438c5da229a51ef73a7ec9c7329a44fbddb969e00