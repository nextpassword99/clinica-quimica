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


def ejecutar_query(query, params=None, is_select=False):
    """
    Ejecuta una consulta SQL en la base de datos MySQL.

    Parámetros:
    query (str): La consulta SQL a ejecutar.
    params (list): Parámetros de la consulta (por defecto es None).
    is_select (bool): Booleano que indica si la consulta es de tipo SELECT (True) o no (False).

    returns:
    list: Si is_select es True, devuelve los resultados de la consulta en forma de lista.
    None: Si la consulta falla, no devuelve nada e imprime un mensaje de error.
    """
    conn = None
    try:
        conn = get_connection()
        if conn is None:
            print("No se pudo establecer la conexión.")
            return []
        cursor = conn.cursor()
        cursor.execute(query, params)
        if is_select:
            return cursor.fetchall()
        else:
            conn.commit()
    except Error as e:
        print(f"Error: {e}")
    finally:
        if conn and conn.is_connected():
            cursor.close()
            conn.close()

