// SPDX-License-Identifier: AGPL
pragma solidity ^0.8.0;

// Определение контракта
contract DataStorage {

    // Адрес владельца контракта
    address private owner;

    // Структура, описывающая данные
    struct Data {
        uint256 id;
        string dataType;
        address dataAddress;
        string link;
    }

    // Хранилище данных
    mapping(uint256 => Data) private data;

    // Конструктор контракта
    constructor() {
        // Установка владельца контракта на адрес того, кто его создал
        owner = msg.sender;
    }

    // Модификатор, проверяющий, что функция вызывается только владельцем контракта
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    // Модификатор, проверяющий, что функция вызывается только авторизованным адресом
    modifier onlyAuthorized() {
        // Инициализация переменной-флага
        bool isAuthorized = false;
        // Адреса, которые могут вызывать функции контракта
        address[] memory authorizedAddresses = new address[](0);
        // Проверка, является ли адрес вызывающего авторизованным
        for (uint i = 0; i < authorizedAddresses.length; i++) {
            if (authorizedAddresses[i] == msg.sender) {
                isAuthorized = true;
                break;
            }
        }
        // В случае, если адрес не является авторизованным, генерируется исключение
        require(isAuthorized, "Not authorized");
        _;
    }

    // Функция добавления данных в хранилище
    function addData(uint256 id, string memory dataType, address dataAddress, string memory link) public onlyAuthorized {
        // Проверка, что данные с заданным ID еще не добавлены
        require(data[id].id == 0, "Data with this ID already exists");
        // Добавление данных в хранилище
        data[id] = Data(id, dataType, dataAddress, link);
    }

    // Функция получения данных из хранилища
    function getData(uint256 id) public view returns (uint256, string memory, address, string memory) {
        // Проверка, что данные с заданным ID есть в хранилище
        require(data[id].id != 0, "Data with this ID does not exist");
        // Возврат данных
        return (data[id].id, data[id].dataType, data[id].dataAddress, data[id].link);
    }

    // Функция обновления данных в хранилище
    function updateData(uint256 id, string memory dataType, address dataAddress, string memory link) public onlyAuthorized {
        // Проверка, что данные с заданным ID есть в хранилище
        require(data[id].id != 0, "Data with this ID does not exist");
        // Обновление данных в хранилище
        Data storage currentData = data[id];
        currentData.dataType = dataType;
        currentData.dataAddress = dataAddress;
        currentData.link = link;
    }
    // Функция удаления данных из хранилища
    function deleteData(uint256 id) public onlyAuthorized {
        // Проверка, что данные с заданным ID есть в хранилище
        require(data[id].id != 0, "Data with this ID does not exist");
        // Удаление данных из хранилища
        delete data[id];
    }

}
