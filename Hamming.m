function Hamming()
    mensaje = [1 1 1 0 0 0 1];

    %Aqui se llama a la funcion par obtener la palabra completa
    codigoHamming = codificarHamming(mensaje);
    fprintf("El codigo de Hamming completo es: ");
    disp(codigoHamming);
    
    %Genera una posicion aleatoria para el error
    bit = randi([1, 11]);

    % Modificar el bit en la posición indicada
    codigoHamming(bit) = ~codigoHamming(bit);
    
    %Muestra la palabra recibida
    fprintf("Palabra recibida (involucra un error): ");
    disp(codigoHamming);

    fprintf("Se comienza el proceso de detectar el error\n");

    %Aqui manda a traer la funcion para buscar el error
    pos_error = deteccion_error(codigoHamming);
    fprintf("Error detectado en la posicion %d\n", pos_error);

    %Aqui se corrige el error en la posicion detectada
    codigoHamming(pos_error) = ~codigoHamming(pos_error);
    fprintf("El codigo de Hamming corregido: ");
    disp(codigoHamming);
end

%Esta funcion obtiene la palabra conpleta que esta formada por las
%paridades y el mensaje
function codigo = codificarHamming(m)
    p1 = mod(m(1) + m(2) + m(4) + m(5) + m(7), 2);
    p2 = mod(m(1) + m(3) + m(4) + m(6) + m(7), 2);
    p4 = mod(m(2) + m(3) + m(4), 2);
    p8 = mod(m(5) + m(6) + m(7), 2);
    codigo = [p1 p2 m(1) p4 m(2) m(3) m(4) p8 m(5) m(6) m(7)];
end

%Con esta funcion obtiene las paridades de la palabra completa
%para hayar el error si es que existe
function pos_error = deteccion_error(c)
    p1 = mod(c(1) + c(3) + c(5) + c(7) + c(9) + c(11), 2);
    p2 = mod(c(2) + c(3) + c(6) + c(7) + c(10) + c(11), 2);
    p4 = mod(c(4) + c(5) + c(6) + c(7), 2);
    p8 = mod(c(8) + c(9) + c(10) + c(11), 2);
    pos_error = (p8 * 8) + (p4 * 4) + (p2 * 2) + p1;
end
