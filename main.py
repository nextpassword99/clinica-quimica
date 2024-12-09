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


def obtenerImcPorDni(dni: int):
    """
    Obtiene el IMC (índice de Masa Corporal) de un paciente mediante su DNI.

    Parámetros:
    dni (int): El DNI del paciente.

    returns:
    list: Devuelve una lista con los datos del IMC calculado y la clasificación del paciente.
    """
    query_detalles_imc_usuario = """
    SELECT DNI,
           nombre,
           apellido,
           TIMESTAMPDIFF(YEAR, fecha_nacimiento, CURDATE()) AS edad,
           peso / ((talla / 100) * (talla / 100)) AS imc,
           CASE
               WHEN peso / ((talla / 100) * (talla / 100)) < 18.5 THEN 'Bajo peso'
               WHEN peso / ((talla / 100) * (talla / 100)) BETWEEN 18.5 AND 24.9 THEN 'Normal'
               WHEN peso / ((talla / 100) * (talla / 100)) BETWEEN 25 AND 29.9 THEN 'Sobrepeso'
               ELSE 'Obesidad'
           END AS clasificacion_imc
    FROM t_paciente
    WHERE DNI = %s;
    """
    params = (dni,)
    return ejecutar_query(query_detalles_imc_usuario, params, is_select=True)


def obtenerAnemiaPorDni(dni: int):
    """
    Obtiene el análisis de anemia de un paciente mediante su DNI.

    Parámetros:
    dni (int): El DNI del paciente.

    returns:
    list: Devuelve una lista con los datos del paciente y su clasificación de anemia (Anemia o Normal).
    """
    query_anemia_usuario = """
    SELECT DNI,
           nombre,
           apellido,
           nivel_emoglobina,
           hematocrito,
           CASE
               WHEN nivel_emoglobina < 12 THEN 'Anemia'
               ELSE 'Normal'
           END AS clasificacion_anemia
    FROM t_paciente
    WHERE DNI = %s;
    """
    params = (dni,)
    return ejecutar_query(query_anemia_usuario, params, is_select=True)


def obtenerHistorialConsultas(dni: int):
    """
    Obtiene el historial de consultas médicas de un paciente.

    Parámetros:
    dni (int): El DNI del paciente.

    returns:
    list: Devuelve una lista con los detalles de cada cita realizada por el paciente.
    """
    query_historial_consultas = """
    SELECT c.fecha_hora, c.motivo, c.estado, m.nombre AS medico, m.apellido
    FROM t_citas c
    JOIN t_medicos m ON c.medico_id = m.medico_id
    WHERE c.paciente_id = %s
    ORDER BY c.fecha_hora DESC;
    """
    params = (dni,)
    return ejecutar_query(query_historial_consultas, params, is_select=True)


def obtenerListaMedicos():
    """
    Obtiene la lista de todos los médicos registrados en la base de datos.

    returns:
    list: Devuelve una lista con los datos de todos los médicos, incluyendo su ID, nombre, apellido y especialidad.
    """

    query_lista_medicos = """
    SELECT medico_id, nombre, apellido, especialidad
    FROM t_medicos;
    """
    return ejecutar_query(query_lista_medicos, is_select=True)


