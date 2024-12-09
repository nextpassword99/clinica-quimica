# **Documentación del Proyecto de Clínica**

## **1. Descripción General**

Este sistema tiene como objetivo gestionar la información de una clínica, incluyendo el registro de pacientes, la programación de citas médicas, el análisis de resultados médicos y la administración de tratamientos. La aplicación proporciona varias funciones clave como la creación y actualización de registros de pacientes, la gestión de citas, la obtención de resultados médicos (como el IMC y los niveles de hemoglobina) y la gestión de tratamientos relacionados con las citas médicas.

## **2. Funciones y Métodos**

### **2.1. `get_connection()`**

- **Descripción**: Establece la conexión con la base de datos MySQL utilizando la librería `mysql.connector`.
- **Propósito**: Esta función se usa para obtener una conexión a la base de datos antes de ejecutar cualquier consulta.
- **Retorno**: Devuelve un objeto `connection`, que se utiliza para interactuar con la base de datos.

### **2.2. `execute_query(query, params=None, is_select=False)`**

- **Descripción**: Ejecuta una consulta SQL en la base de datos.
- **Propósito**: Esta función maneja tanto consultas de selección (SELECT) como consultas de modificación (INSERT, UPDATE, DELETE). Si `is_select` es `True`, la función devolverá los resultados de la consulta; de lo contrario, ejecutará una consulta que modifica los datos.
- **Parámetros**:
  - `query`: La consulta SQL a ejecutar.
  - `params`: Parámetros para la consulta (por defecto es `None`).
  - `is_select`: Un valor booleano que indica si la consulta es un `SELECT` (`True`) o no (`False`).
- **Retorno**: Si `is_select` es `True`, devuelve los resultados de la consulta. Si no, no retorna nada.

### **2.3. `getImcFromDni(dni)`**

- **Descripción**: Obtiene el IMC (Índice de Masa Corporal) de un paciente utilizando su DNI.
- **Propósito**: Calcula el IMC del paciente y lo clasifica según los rangos establecidos (bajo peso, peso normal, sobrepeso, obesidad).
- **Parámetros**:
  - `dni`: El DNI del paciente.
- **Retorno**: Devuelve una lista con los datos del IMC calculado y la clasificación del paciente.

### **2.4. `getAnemiaFromDni(dni)`**

- **Descripción**: Obtiene el análisis de anemia de un paciente usando su DNI.
- **Propósito**: Se utiliza para obtener los niveles de hemoglobina y hematocrito del paciente y determinar si presenta anemia.
- **Parámetros**:
  - `dni`: El DNI del paciente.
- **Retorno**: Devuelve una lista con la información sobre la anemia del paciente y su clasificación.

### **2.5. `getHistorialConsultas(dni)`**

- **Descripción**: Obtiene el historial de consultas médicas de un paciente.
- **Propósito**: Muestra todas las citas previas del paciente, con detalles como la fecha, el motivo de la consulta, el estado de la cita y el nombre del médico.
- **Parámetros**:
  - `dni`: El DNI del paciente.
- **Retorno**: Devuelve una lista de registros con los detalles de cada cita realizada.

### **2.6. `obtenerListaMedicos()`**

- **Descripción**: Obtiene la lista de todos los médicos registrados en la base de datos.
- **Propósito**: Permite ver los médicos disponibles en la clínica, incluyendo su nombre, apellido y especialidad.
- **Retorno**: Devuelve una lista con los datos de todos los médicos.

### **2.7. `crearCita(paciente_id, medico_id, fecha_hora, motivo)`**

- **Descripción**: Crea una nueva cita médica para un paciente con un médico específico.
- **Propósito**: Registra una nueva cita médica en la base de datos, asignando un paciente y un médico para la cita.
- **Parámetros**:
  - `paciente_id`: El ID del paciente.
  - `medico_id`: El ID del médico.
  - `fecha_hora`: La fecha y hora de la cita.
  - `motivo`: El motivo de la cita.
- **Retorno**: No retorna nada. Imprime un mensaje de éxito cuando se crea la cita.

### **2.8. `agregarTratamiento(cita_id, medicamento_id, cantidad, descripcion, costo)`**

- **Descripción**: Agrega un tratamiento a una cita médica específica.
- **Propósito**: Permite registrar un tratamiento asociado a una cita, especificando el medicamento, cantidad, descripción y costo.
- **Parámetros**:
  - `cita_id`: El ID de la cita médica.
  - `medicamento_id`: El ID del medicamento.
  - `cantidad`: La cantidad del medicamento.
  - `descripcion`: Descripción del tratamiento.
  - `costo`: El costo del tratamiento.
- **Retorno**: No retorna nada. Imprime un mensaje de éxito al finalizar.

### **2.9. `nuevoPaciente(dni, nombre, apellido, fecha_nacimiento, peso, talla, ubicacion)`**

- **Descripción**: Registra un nuevo paciente en la base de datos.
- **Propósito**: Permite agregar un nuevo paciente a la base de datos de la clínica.
- **Parámetros**:
  - `dni`: El DNI del paciente.
  - `nombre`: El nombre del paciente.
  - `apellido`: El apellido del paciente.
  - `fecha_nacimiento`: La fecha de nacimiento del paciente.
  - `peso`: El peso del paciente.
  - `talla`: La talla del paciente en centímetros.
  - `ubicacion`: La ubicación geográfica del paciente.
- **Retorno**: No retorna nada. Imprime un mensaje de éxito o error (si el paciente ya existe).

### **2.10. `eliminarPaciente(dni)`**

- **Descripción**: Elimina un paciente de la base de datos.
- **Propósito**: Permite borrar un paciente de la base de datos utilizando su DNI como identificador.
- **Parámetros**:
  - `dni`: El DNI del paciente a eliminar.
- **Retorno**: No retorna nada. Imprime un mensaje de éxito al finalizar.

### **2.11. `actualizarPaciente(dni, nombre, apellido, fecha_nacimiento, peso, talla, ubicacion)`**

- **Descripción**: Actualiza la información de un paciente en la base de datos.
- **Propósito**: Modifica los detalles de un paciente (nombre, apellido, fecha de nacimiento, peso, talla, ubicación).
- **Parámetros**:
  - `dni`: El DNI del paciente.
  - `nombre`: El nuevo nombre del paciente.
  - `apellido`: El nuevo apellido del paciente.
  - `fecha_nacimiento`: La nueva fecha de nacimiento del paciente.
  - `peso`: El nuevo peso del paciente.
  - `talla`: La nueva talla del paciente.
  - `ubicacion`: La nueva ubicación geográfica del paciente.
- **Retorno**: No retorna nada. Imprime un mensaje de éxito al finalizar.

### **2.12. `obtenerTratamientosPorCita(cita_id)`**

- **Descripción**: Obtiene los tratamientos asociados a una cita médica.
- **Propósito**: Permite listar todos los tratamientos relacionados con una cita médica específica.
- **Parámetros**:
  - `cita_id`: El ID de la cita médica.
- **Retorno**: Devuelve una lista con los detalles de los tratamientos asociados a la cita.

## **3. Interfaz de Usuario**

El sistema tiene un menú interactivo que permite a los usuarios seleccionar distintas opciones para gestionar pacientes, médicos, citas y tratamientos. Las opciones disponibles en el menú son:

1. Crear paciente
2. Ver paciente (IMC, Anemia, Historial)
3. Crear cita
4. Ver lista de médicos
5. Agregar tratamiento
6. Eliminar paciente
7. Actualizar paciente
8. Ver tratamientos por cita
9. Salir

Cada opción ofrece una funcionalidad específica que permite realizar las operaciones correspondientes.

## **4. Manejo de Errores y Validaciones**

Se implementan varias validaciones para asegurar que los datos ingresados sean correctos y que no haya problemas al interactuar con la base de datos:

- **DNI inválido**: Si se ingresa un valor incorrecto para el DNI (por ejemplo, un texto en lugar de un número), se muestra un mensaje de error y se solicita nuevamente la entrada.
- **Datos no encontrados**: Si no se encuentran registros (por ejemplo, no hay citas o IMC registrado), se informa al usuario de manera clara.
- **Existencia de paciente**: Al intentar registrar un nuevo paciente, se valida que el paciente no exista previamente en la base de datos.

## **5. Requisitos**

- Python 3.x
- MySQL (conector `mysql-connector-python`)
- Una base de datos MySQL configurada con las tablas `t_paciente`, `t_medicos`, `t_citas`, `t_tratamientos`, `t_medicamentos`.
