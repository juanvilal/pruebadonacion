pragma solidity >=0.4.22 <0.6.0;
contract Donacion {
//Eventos neccesarios para conocer si se ha realizado ya la donacion y que tipo de obsequio se le daría al donante.
event donado (bool);
event premio1 (bool);
event premio2 (bool);
//struct que nos almacena los siguientes datos con respecto a la transaccion
    struct Transaccion {
        uint256 precio;
        string nombre;
        string motivo;
    }
//Declaración de variables de tipo storage
    uint8 public numdonaciones;
    bool estado; //Variables de estado necesarias para emitir los eventos
    bool estadop1;//
    bool estadop2;//
    string public premio; //
    address public wallet = 0xe54589F634C6De4ef04FE17d5d6cef85f2D62cB5;  //variable para almacenar la dirección a la que se va a donar
    mapping(address => Transaccion) transaccionBeneficiario; //mapping en el que relaciona un valor clave address con el struct Transaccion
    mapping(address => string) premioBeneficiario; //mapping que relaciona un valor clave de tipo address con una variable de tipo string que será el obsequio.
    string [] premios;
    uint donacionMinima;
//funcion que se ejecutará cada vez que despleguemos nuestro smart contract
    constructor() public {
        premios.push("obsequio1");
        premios.push("obsequio2");
        donacionMinima = 1 ether; //la donacion minima sera de 1 ether
    }
    
/// Transaccion de la donacion
    function donar(
        uint8 _dinero,
        string memory _nombre,
        string memory _motivo
        ) public 
        payable
        {
        
            require(msg.value >= donacionMinima); //Si el valor introducido por la persona que despliega el contrato no supera la donacionMinima no se ejecutará la función
            if (msg.value >3 ether){
                transaccionBeneficiario[wallet] = Transaccion(_dinero, _nombre, _motivo);//Almacenamos en la dirección de la persona que llama a la función los parametros de la funcion
                premioBeneficiario[msg.sender] = premios[0];    //Relacionamos con la direccion de la persona que llama a la función el tipo de premio que se le va otorgar
                estadop1 = true; //variable necesaria para que se ejecute nuestro evento
                premio = "obsequio1";
                emit premio1(estadop1);
            }
            else //Si el valor introducido no supera los 3 ether se ejecutará las siguientes lineas de código con la misma estructura que el if de arriba
            {
                transaccionBeneficiario[wallet] = Transaccion(_dinero, _nombre, _motivo);
                premioBeneficiario[msg.sender] = premios[1];
                estadop2 = true;
                premio = "obsequio2";
                emit premio2(estadop2);
            }
            emit donado (estado); //Si se valida el require y se ejecuta cualquier bucle condicional de arriba nuestra se lanzará este evento
            numdonaciones++; //se va incrementando a medida que se se ejecuta esta funcion (se dona).
    }

}