# **Documentación del Proyecto de Clínica**

### **1. Descripción General**

Este sistema está diseñado para manejar información de una clínica, que incluye la gestión de pacientes, citas médicas, tratamientos, análisis de resultados médicos y gestión de médicos. Proporciona varias funcionalidades que permiten crear y actualizar registros de pacientes, gestionar citas, obtener información médica (como el IMC y los niveles de hemoglobina) y manejar los tratamientos asociados a las citas.

### **2. Funciones y Métodos**

#### **2.1. `get_connection()`**

- **Descripción:** Establece una conexión con la base de datos MySQL utilizando el conector `mysql.connector`.
- **Propósito:** Esta función se utiliza para conectarse a la base de datos antes de ejecutar cualquier consulta SQL.
- **Retorno:** Devuelve un objeto `connection` que se usa para interactuar con la base de datos.

#### **2.2. `execute_query(query, params=None, is_select=False)`**

- **Descripción:** Ejecuta una consulta SQL en la base de datos.
- **Propósito:** Esta función maneja tanto las consultas de selección como las de modificación. Si `is_select` es `True`, devuelve los resultados de la consulta, de lo contrario, ejecuta una consulta de modificación (INSERT, UPDATE, DELETE).
- **Parámetros:**
  - `query`: La consulta SQL a ejecutar.
  - `params`: Parámetros de la consulta (por defecto es `None`).
  - `is_select`: Booleano que indica si la consulta es de tipo SELECT (`True`) o no (`False`).
- **Retorno:** Devuelve el resultado de la consulta si `is_select` es `True`, de lo contrario, no retorna nada.

#### **2.3. `getImcFromDni(dni)`**

- **Descripción:** Obtiene el IMC (Índice de Masa Corporal) de un paciente mediante su DNI.
- **Propósito:** Se utiliza para calcular el IMC del paciente y clasificarlo según los rangos establecidos (bajo peso, normal, sobrepeso, obesidad).
- **Parámetros:**
  - `dni`: El DNI del paciente.
- **Retorno:** Devuelve una lista con los datos del IMC calculado y la clasificación del paciente.

#### **2.4. `getAnemiaFromDni(dni)`**

- **Descripción:** Obtiene el análisis de anemia de un paciente mediante su DNI.
- **Propósito:** Se utiliza para obtener el nivel de hemoglobina y hematocrito de un paciente y determinar si el paciente tiene anemia.
- **Parámetros:**
  - `dni`: El DNI del paciente.
- **Retorno:** Devuelve una lista con los datos sobre anemia del paciente y su clasificación.

#### **2.5. `getHistorialConsultas(dni)`**

- **Descripción:** Obtiene el historial de consultas médicas de un paciente.
- **Propósito:** Muestra todas las consultas previas de un paciente, junto con la información sobre la fecha de la consulta, el motivo, el estado de la cita y el nombre del médico.
- **Parámetros:**
  - `dni`: El DNI del paciente.
- **Retorno:** Devuelve una lista de registros con los detalles de cada cita realizada.

#### **2.6. `obtenerListaMedicos()`**

- **Descripción:** Obtiene la lista de todos los médicos registrados en la base de datos.
- **Propósito:** Se utiliza para mostrar a los médicos disponibles en la clínica, incluyendo su nombre, apellido y especialidad.
- **Retorno:** Devuelve una lista con los datos de todos los médicos.

#### **2.7. `crearCita(paciente_id, medico_id, fecha_hora, motivo)`**

- **Descripción:** Crea una nueva cita médica para un paciente con un médico específico.
- **Propósito:** Se utiliza para registrar una nueva cita médica en la base de datos, asignando un paciente a un médico y especificando el motivo de la cita.
- **Parámetros:**
  - `paciente_id`: El ID del paciente.
  - `medico_id`: El ID del médico.
  - `fecha_hora`: La fecha y hora de la cita.
  - `motivo`: El motivo de la cita.
- **Retorno:** No retorna nada. Imprime un mensaje de éxito al finalizar.

#### **2.8. `agregarTratamiento(cita_id, medicamento_id, cantidad, descripcion, costo)`**

- **Descripción:** Agrega un tratamiento a una cita médica específica.
- **Propósito:** Se utiliza para agregar un tratamiento asociado a una cita, incluyendo el medicamento, la cantidad, la descripción y el costo.
- **Parámetros:**
  - `cita_id`: El ID de la cita médica.
  - `medicamento_id`: El ID del medicamento.
  - `cantidad`: La cantidad del medicamento.
  - `descripcion`: Descripción del tratamiento.
  - `costo`: El costo del tratamiento.
- **Retorno:** No retorna nada. Imprime un mensaje de éxito al finalizar.

#### **2.9. `nuevoPaciente(dni, nombre, apellido, fecha_nacimiento, peso, talla, ubicacion)`**

- **Descripción:** Registra un nuevo paciente en la base de datos.
- **Propósito:** Se utiliza para agregar un nuevo paciente a la base de datos de pacientes.
- **Parámetros:**
  - `dni`: El DNI del paciente.
  - `nombre`: El nombre del paciente.
  - `apellido`: El apellido del paciente.
  - `fecha_nacimiento`: La fecha de nacimiento del paciente.
  - `peso`: El peso del paciente.
  - `talla`: La talla del paciente en centímetros.
  - `ubicacion`: La ubicación geográfica del paciente.
- **Retorno:** No retorna nada. Imprime un mensaje de éxito o error (si el paciente ya existe).

#### **2.10. `eliminarPaciente(dni)`**

- **Descripción:** Elimina un paciente de la base de datos.
- **Propósito:** Se utiliza para eliminar un paciente de la base de datos, usando su DNI como identificador.
- **Parámetros:**
  - `dni`: El DNI del paciente a eliminar.
- **Retorno:** No retorna nada. Imprime un mensaje de éxito al finalizar.

#### **2.11. `actualizarPaciente(dni, nombre, apellido, fecha_nacimiento, peso, talla, ubicacion)`**

- **Descripción:** Actualiza la información de un paciente en la base de datos.
- **Propósito:** Se utiliza para modificar los detalles de un paciente (nombre, apellido, fecha de nacimiento, peso, talla, ubicación).
- **Parámetros:**
  - `dni`: El DNI del paciente.
  - `nombre`: El nuevo nombre del paciente.
  - `apellido`: El nuevo apellido del paciente.
  - `fecha_nacimiento`: La nueva fecha de nacimiento del paciente.
  - `peso`: El nuevo peso del paciente.
  - `talla`: La nueva talla del paciente.
  - `ubicacion`: La nueva ubicación geográfica del paciente.
- **Retorno:** No retorna nada. Imprime un mensaje de éxito al finalizar.

#### **2.12. `obtenerTratamientosPorCita(cita_id)`**

- **Descripción:** Obtiene los tratamientos asociados a una cita médica.
- **Propósito:** Se utiliza para listar todos los tratamientos asignados a una cita médica específica.
- **Parámetros:**
  - `cita_id`: El ID de la cita médica.
- **Retorno:** Devuelve una lista con los detalles de los tratamientos asociados a la cita.

---

### **3. Interfaz de Usuario**

La interfaz de usuario es un menú interactivo que permite al usuario seleccionar distintas opciones para gestionar pacientes, médicos, citas y tratamientos.

El menú presenta las siguientes opciones:

1. Crear paciente
2. Ver paciente (IMC, Anemia, Historial)
3. Crear cita
4. Ver lista de médicos
5. Agregar tratamiento
6. Eliminar paciente
7. Actualizar paciente
8. Ver tratamientos por cita
9. Salir

Cada opción tiene su propia funcionalidad y permite realizar las operaciones correspondientes según las necesidades del usuario.

---

### **4. Manejo de Errores y Validaciones**

Las funciones de consulta incluyen manejo de errores y validaciones para garantizar que los datos ingresados sean correctos y que no haya problemas al interactuar con la base de datos:

- **Valor no válido en el DNI:** Si se introduce un valor incorrecto para el DNI (como una cadena en lugar de un número), se mostrará un mensaje de error y se pedirá al usuario que vuelva a intentarlo.
- **Datos no encontrados:** Si no se encuentran registros en la base de datos (por ejemplo, no hay historial de citas o datos de IMC), se informa al usuario.
- **Existencia de paciente:** Al intentar crear un nuevo paciente, se valida si el paciente ya existe en la base de datos mediante el DNI.

---

### **5. Requisitos**

- Python 3.x
- MySQL (conector `mysql-connector-python`)
- Una base de datos MySQL configurada con las tablas `t_paciente`, `t_medicos

`, `t_citas`, `t_tratamientos`, `t_medicamentos`.
