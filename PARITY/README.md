# PARITY POA

## Directorio con los UTC de las cuentas de Ethereum en Parity

~/.local/share/io.parity.ethereum/keys/ethereum

## Consejos

- network/spec.json:
    No minar un bloque cada menos de 5 segundos, puede causasr desincronizacion en los nodos.
    Multi: La clave de valor es el bloque a partir del que se toma esa lista como valida
    params.minGasLimit: numero por convencion para el genesis ```0x1388```

## Iniciar la red en local

enode://de85ff5b08ea5a5e62fe5ddfb00aa998e334c98aa766ab6bea39152fa7be1295dced078fd699882e8ab87e73e15f9c15aaca9e16396b4205630aa7e374f0907f@192.168.100.131:30303

parity --config authority.toml --jsonrpc-apis all --geth --logging=rpc=trace

0xCAFE -> 08h en hexadecimal

UTC KEYS:
Mac OS X: ~/Library/Application\ Support/io.parity.ethereum/keys/ethereum/
Linux: $HOME/.local/share/io.parity.ethereum/keys
Windows 7/10: %HOMEPATH%/AppData/Roaming/Parity/Ethereum/keys