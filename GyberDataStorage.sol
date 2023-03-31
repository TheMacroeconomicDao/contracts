// SPDX-License-Identifier: AGPL
pragma solidity ^0.8.0;

// Определение Контракта
contract GyberStorage{

    //Адрес владельца
    address private owner;

    //Адреса которые могут вызвать функции контракта
    address[] private authorizedAddresses;

    //Структура Данных
    struct Data{
        uint256 id;
        string dataType;
        address userAddress;
        string linkIpfs;
    }

    //Хранилище Данных
    mapping(uint256 => Data) private data;

    //Конструктор контракта
    constructor(){
        owner = msg.sender;
    }

    // Модификатор, проверяющий, что функция вызывается только владельцем контракта
    modifier onlyOwner(){
        require(msg.sender == owner,'Only owner can call this function');
        _;
    }

    // Модификатор, проверяющий, что функция вызывается только авторизованным адресом
    modifier onlyAuthorized(){
    // Инициализация переменной-флага
    bool isAuthorized = false;
    // Проверка, является ли адрес вызывающего авторизованным
    for (uint i = 0;i < authorizedAddresses.length;i++){
        if (authorizedAddresses[i] == msg.sender){
            isAuthorized = true;
            break;
        }
    }
    
    // В случае, если адрес не является авторизованным, генерируется исключение
    require(isAuthorized,"Not authorized");
    _;

    }
    // Функция добавления авторизованного адреса
    function addAuthorizedAddress(address _address) public onlyOwner {
        authorizedAddresses.push(_address);
    }

    // Функция удаления авторизованного адреса
    function removeAuthorizedAddress(address _address) public onlyOwner {
        for (uint i = 0; i < authorizedAddresses.length; i++){
            if (authorizedAddresses[i] == _address){
                delete authorizedAddresses[i];
            }
        }
    }

    // Функция добавления данных в хранилище
    function addData(uint256 id, string memory dataType, address userAddress, string memory linkIpfs) public onlyAuthorized {
    // Проверка, что данные с заданным ID еще не добавлены
    require(data[id].id == 0);
    // Добавление данных в хранилище
    data[id] = Data(id, dataType, userAddress, linkIpfs);

    }
    // Функция получения данных из хранилища
    function getData(uint256 id,address userAddress,string memory dataType ) public view returns (uint256, string memory, address , string memory){
    // Проверка, что данные с заданным ID есть в хранилище
    require(data[id].id != 0,"Data with this ID does not exist");
    // Возврат данных
    return (data[id].id, data[id].dataType, data[id].userAddress, data[id].linkIpfs);
    }

    // Функция обновления данных в хранилище
    function updateData(uint256 id, string memory dataType, address userAddress, string memory linkIpfs) public onlyAuthorized{
    // Проверка, что данные с заданным ID есть в хранилище
    require(data[id].id != 0,"Data with this ID does not exist");
    // Удаление данных из хранилища
    delete data[id];
    }

}