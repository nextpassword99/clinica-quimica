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


def crearCita(paciente_id: int, medico_id: int, fecha_hora: str, motivo: str):
    """
    Crea una nueva cita médica para un paciente con un médico específico.

    Parámetros:
    paciente_id (int): El ID del paciente.
    medico_id (int): El ID del médico.
    fecha_hora (str): La fecha y hora de la cita en formato 'YYYY-MM-DD HH:MM:SS'.
    motivo (str): El motivo de la cita.

    returns:
    None. Imprime un mensaje de éxito al finalizar.
    """
    query_crear_cita = """
    INSERT INTO t_citas (paciente_id, medico_id, fecha_hora, motivo, estado)
    VALUES (%s, %s, %s, %s, 'pendiente');
    """
    params = (paciente_id, medico_id, fecha_hora, motivo)
    ejecutar_query(query_crear_cita, params, is_select=False)
    print("Cita creada con éxito")


def agregarTratamiento(cita_id: int, medicamento_id: int, cantidad: float, descripcion: str, costo: float):
    """
    Agrega un tratamiento a una cita médica específica.

    Parámetros:
    cita_id (int): El ID de la cita médica.
    medicamento_id (int): El ID del medicamento.
    cantidad (float): La cantidad del medicamento.
    descripcion (str): La descripción del tratamiento.
    costo (float): El costo del tratamiento.

    returns:
    None. Imprime un mensaje de éxito al finalizar.
    """
    query = """
    INSERT INTO t_tratamientos (cita_id, medicamento_id, cantidad, descripcion, costo, fecha_tratamiento)
    VALUES (%s, %s, %s, %s, %s, CURDATE());
    """
    params = (cita_id, medicamento_id, cantidad, descripcion, costo)
    ejecutar_query(query, params, is_select=False)
    print("Tratamiento agregado con éxito")


def nuevoPaciente(dni: int, nombre: str, apellido: str, fecha_nacimiento: str, sexo: str, peso: float, talla: float, ubicacion: str):
    """
    Registra un nuevo paciente en la base de datos.

    Parámetros:
    dni (int): El DNI del paciente.
    nombre (str): El nombre del paciente.
    apellido (str): El apellido del paciente.
    fecha_nacimiento (str): La fecha de nacimiento del paciente en formato 'YYYY-MM-DD'.
    sexo (str): El sexo del paciente ('M' o 'F').
    peso (float): El peso del paciente en kilogramos.
    talla (float): La talla del paciente en centímetros.
    ubicacion (str): La ubicación geográfica del paciente.

    returns:
    None. Imprime un mensaje de éxito si el paciente es registrado correctamente o
    un mensaje de error si el paciente ya existe en la base de datos.
    """
    query_val = """
    SELECT DNI FROM t_paciente WHERE DNI = %s;
    """
    result = ejecutar_query(query_val, (dni,), is_select=True)

    if len(result) > 0:
        print("El paciente ya existe")
    else:
        query = """
        INSERT INTO t_paciente (DNI, nombre, apellido, fecha_nacimiento, sexo, peso, talla, ubicacion_geografica)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s);
        """
        params = (dni, nombre, apellido, fecha_nacimiento, sexo,
                  peso, talla, ubicacion)
        ejecutar_query(query, params, is_select=False)
        print("Paciente creado con éxito")


def actualizarPaciente(dni: int, nombre: str, apellido: str, fecha_nacimiento: str, sexo: str, telefono: str, nivel_emoglobina: float, hematocrito: float, peso: float, talla: float, ubicacion: str):
    """
    Actualiza la información de un paciente en la base de datos.

    Parámetros:
    dni (int): El DNI del paciente.
    nombre (str): El nuevo nombre del paciente.
    apellido (str): El nuevo apellido del paciente.
    fecha_nacimiento (str): La nueva fecha de nacimiento del paciente en formato 'YYYY-MM-DD'.
    sexo (str): El nuevo sexo del paciente ('M' o 'F').
    telefono (str): El nuevo número de teléfono del paciente.
    nivel_emoglobina (float): El nuevo nivel de hemoglobina del paciente.
    hematocrito (float): El nuevo valor de hematocrito del paciente.
    peso (float): El nuevo peso del paciente en kilogramos.
    talla (float): La nueva talla del paciente en centímetros.
    ubicacion (str): La nueva ubicación geográfica del paciente.

    returns:
    None. Imprime un mensaje de éxito al finalizar la actualización.
    """
    query = """
    UPDATE t_paciente 
    SET nombre = %s, apellido = %s, fecha_nacimiento = %s, sexo = %s, telefono = %s, nivel_emoglobina = %s, hematocrito = %s, peso = %s, talla = %s, ubicacion_geografica = %s
    WHERE DNI = %s;
    """
    params = (nombre, apellido, fecha_nacimiento, sexo, telefono,
              nivel_emoglobina, hematocrito, peso, talla, ubicacion, dni)
    ejecutar_query(query, params, is_select=False)
    print("Paciente actualizado con éxito")


def obtenerTratamientosPorCita(cita_id: int):
    """
    Obtiene los tratamientos asociados a una cita médica.

    Parámetros:
    cita_id (int): El ID de la cita médica.

    returns:
    list: Devuelve una lista con los detalles de los tratamientos asociados a la cita, incluyendo descripción, cantidad, costo, nombre del medicamento y fecha del tratamiento.
    """
    query_tratamientos = """
    SELECT t.descripcion, t.cantidad, t.costo, m.nombre AS medicamento, t.fecha_tratamiento
    FROM t_tratamientos t
    JOIN t_medicamentos m ON t.medicamento_id = m.medicamento_id
    WHERE t.cita_id = %s;
    """
    params = (cita_id,)
    return ejecutar_query(query_tratamientos, params, is_select=True)


def main():
    """
    Punto de entrada principal del programa. Presenta un menú interactivo al usuario para
    realizar operaciones en la base de datos de pacientes y médicos.

    El menú permite al usuario:
    1. Crear un paciente
    2. Ver un paciente (IMC, Anemia, Historial)
    3. Crear una cita
    4. Ver la lista de médicos
    5. Agregar un tratamiento
    6. Actualizar un paciente
    7. Ver los tratamientos por cita
    8. Salir

    Cada opción tiene su propia funcionalidad y permite realizar las operaciones
    correspondientes según las necesidades del usuario.
    """

    while True:
        print("""
        Bienvenido a la clínica
        1. Crear paciente
        2. Ver paciente (IMC, Anemia, Historial)
        3. Crear cita
        4. Ver lista de médicos
        5. Agregar tratamiento
        6. Actualizar paciente
        7. Ver tratamientos por cita
        8. Salir
        """)

        try:
            opt = int(input("Seleccione una opción: "))
        except ValueError:
            print("Opción inválida. Por favor, ingrese un número entre 1 y 9.")
            continue

        if opt == 1:
            try:
                dni = int(input("Introduce tu DNI: "))
                nombre = input("Introduce tu nombre: ")
                apellido = input("Introduce tu apellido: ")
                fecha_nacimiento = input(
                    "Introduce tu fecha de nacimiento (YYYY-MM-DD): ")
                sexo = input("Introduce tu sexo (M/F): ")
                peso = float(input("Introduce tu peso en kg: "))
                talla = float(input("Introduce tu talla en cm: "))
                ubicacion = input("Introduce tu ubicación geográfica: ")
                nuevoPaciente(dni, nombre, apellido, fecha_nacimiento, sexo,
                              peso, talla, ubicacion)
            except ValueError:
                print("Datos incorrectos. Asegúrese de ingresar valores válidos.")
                continue

        elif opt == 2:
            try:
                dni = int(input("Introduce tu DNI: "))

                print("\n--- IMC ---")
                imc_resultado = obtenerImcPorDni(dni)
                if imc_resultado:
                    for row in imc_resultado:
                        print(f"DNI: {row[0]}, Nombre: {row[1]} {row[2]}, Edad: {
                              row[3]}, IMC: {row[4]:.2f}, Clasificación: {row[5]}")
                else:
                    print("No se encontraron datos de IMC.")

                print("\n--- Anemia ---")
                anemia_resultado = obtenerAnemiaPorDni(dni)
                if anemia_resultado:
                    for row in anemia_resultado:
                        print(f"DNI: {row[0]}, Nombre: {row[1]} {row[2]}, Nivel de Hemoglobina: {
                              row[3]}, Hematocrito: {row[4]}, Clasificación: {row[5]}")
                else:
                    print("No se encontraron datos de Anemia.")

                print("\n--- Historial de Consultas ---")
                historial = obtenerHistorialConsultas(dni)
                if historial:
                    for consulta in historial:
                        print(f"Fecha: {consulta[0]}, Motivo: {consulta[1]}, Estado: {
                              consulta[2]}, Médico: {consulta[3]} {consulta[4]}")
                else:
                    print("No se encontraron consultas para este paciente.")

            except ValueError:
                print(
                    "El DNI ingresado no es válido. Por favor ingresa un número de DNI correcto.")
                continue

        elif opt == 3:
            try:
                paciente_id = int(input("Introduce el DNI del paciente: "))
                medico_id = int(input("Introduce el ID del médico: "))
                fecha_hora = input(
                    "Introduce la fecha y hora de la cita (YYYY-MM-DD HH:MM): ")
                motivo = input("Introduce el motivo de la cita: ")
                crearCita(paciente_id, medico_id, fecha_hora, motivo)
            except ValueError:
                print("Datos incorrectos. Asegúrese de ingresar valores válidos.")
                continue

        elif opt == 4:
            medicos = obtenerListaMedicos()
            print("Lista de médicos:")
            for medico in medicos:
                print(f"""ID: {medico[0]}, Nombre: {medico[1]} {
                      medico[2]}, Especialidad: {medico[3]}""")

        elif opt == 5:
            try:
                cita_id = int(input("Introduce el ID de la cita: "))
                medicamento_id = int(
                    input("Introduce el ID del medicamento: "))
                cantidad = float(input("Introduce la cantidad administrada: "))
                descripcion = input(
                    "Introduce la descripción del tratamiento: ")
                costo = float(input("Introduce el costo del tratamiento: "))
                agregarTratamiento(cita_id, medicamento_id,
                                   cantidad, descripcion, costo)
            except ValueError:
                print("Datos incorrectos. Asegúrese de ingresar valores válidos.")
                continue

        elif opt == 7:
            try:
                dni = int(input("Introduce tu DNI: "))
                nombre = input("Introduce tu nombre: ")
                apellido = input("Introduce tu apellido: ")
                fecha_nacimiento = input(
                    "Introduce tu fecha de nacimiento (YYYY-MM-DD): ")
                sexo = input("Introduce tu sexo (M/F): ")
                telefono = input("Introduce tu teléfono: ")
                nivel_emoglobina = float(
                    input("Introduce tu nivel de emoglobina (g/dL): "))
                hematocrito = float(input("Introduce tu hematocrito (%): "))
                peso = float(input("Introduce tu peso: "))
                talla = float(input("Introduce tu talla en cm: "))
                ubicacion = input("Introduce tu ubicación geográfica: ")
                actualizarPaciente(dni, nombre, apellido, fecha_nacimiento, sexo,
                                   telefono, nivel_emoglobina, hematocrito, peso, talla, ubicacion)
            except ValueError:
                print("Datos incorrectos. Asegúrese de ingresar valores válidos.")
                continue

        elif opt == 8:
            try:
                cita_id = int(input("Introduce el ID de la cita: "))
                tratamientos = obtenerTratamientosPorCita(cita_id)
                print("Tratamientos asociados a la cita:")
                for tratamiento in tratamientos:
                    print(f"Medicamento: {tratamiento[3]}, Descripción: {tratamiento[0]}, Cantidad: {
                          tratamiento[1]}, Costo: {tratamiento[2]}, Fecha: {tratamiento[4]}")
            except ValueError:
                print("El ID de la cita ingresado no es válido.")
                continue

        elif opt == 9:
            print("¡Final!")
            break


if __name__ == '__main__':
    main()
