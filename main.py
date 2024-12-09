import mysql.connector
from mysql.connector import Error


def get_connection():
    """
    Establece y devuelve una conexión a la base de datos MySQL utilizando los parámetros especificados.

    returns:
    mysql.connector.connection_cext.cmysqlconnection: un objeto de conexión a la base de datos MySQL si tiene éxito.
    None: si la conexión falla, no devuelve nada e imprime un mensaje de error.
    """
    try:
        return mysql.connector.connect(
            host="localhost",
            port=3306,
            user="root",
            password="123456",
            database="pruebas",
            charset="utf8mb4",
            collation="utf8mb4_general_ci"
        )
    except Error as e:
        print(f"Error al conectar a la base de datos: {e}")
        return None


