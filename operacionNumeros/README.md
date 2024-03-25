Aprendizaje

Registros:

**• AX:** Acomulador, mediante este registro se ejecutan todas las operaciones básicas aritmeticas, algunas requieren de caracter exclusivo realizarse mediante este registro multiproposito.

    **- Mul:** Toma como parametro un solo elemento y lo multiplica por el **contenido de ax**, el **excedente lo coloca en dx**, (Fue uno de los problemas iniciales, ya que usaba dx para guardar datos sin darme cuenta que era actualizado a 0h por no contener residuo).

**- Div: ** Toma como parametro un solo elemento y divide por el **contenido de ax**, el **cociente** permanece en **ax** y el **residuo** en **dx**, (Es importante no manipular el registro dx, ya que es susceptible de dar error a un error de overflow).
