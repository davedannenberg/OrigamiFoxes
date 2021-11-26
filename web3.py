import json
from web3 import Web3, HTTPProvider, contract

#blockchain address
blockchain_address = 'http://127.0.0.1:7545'
#instance to interact w blockchain
web3 = Web3(HTTPProvider(blockchain_address))
#default address
web3.eth.defaultAccount = web3.eth.accounts[0]

compiled_contract_path = ''
deployed_contract_address = ''

with open(compiled_contract_path) as file:
    contract_json = json.load(file)
    contract_abi = contract_json['abi']

contract = web3.eth.contract(address=deployed_contract_address, abi=contract_abi)

result = contract.functions.setValue(10).transact()
print(result)
message = contract.functions.getValue.call()
print(message)