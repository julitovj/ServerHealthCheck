#!/bin/bash

# Verificar el estado del servidor

# Función para verificar espacio en disco
check_disk_space() {
    echo "=== Espacio en Disco ==="
    df -h
    echo ""
}

# Función para verificar los procesos en ejecución
check_running_processes() {
    echo "=== Procesos en Ejecución ==="
    ps aux --sort=-%mem | head -n 10
    echo ""
}

# Función para verificar los procesos críticos
check_critical_processes() {
    echo "=== Procesos Críticos ==="
    critical_processes=("sshd" "nginx" "mysql" "docker")
    for process in "${critical_processes[@]}"; do
        if pgrep -x "$process" > /dev/null; then
            echo "$process está corriendo"
        else
            echo "ALERTA: $process no está corriendo"
        fi
    done
    echo ""
}

# Función para verificar alertas del sistema
check_system_alerts() {
    echo "=== Alertas del Sistema ==="
    dmesg | grep -i 'error\|fail\|critical' | tail -n 10
    echo ""
}

# Función para obtener información del sistema usando dmidecode
check_dmidecode_info() {
    echo "=== Información del Sistema (dmidecode) ==="
    sudo dmidecode -t system
    echo ""
}

# Verificar el estado del servidor
echo "=== Estado del Servidor ==="
uptime
echo ""

# Llamar a las funciones
check_disk_space
check_running_processes
check_critical_processes
check_system_alerts
check_dmidecode_info

echo "Verificación completada."

