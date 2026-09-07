document.addEventListener("DOMContentLoaded", () => {
    console.log("Servidor web empresa.local funcionando correctamente.");

    const mensaje = document.createElement("p");
    mensaje.textContent = "JavaScript cargado correctamente.";
    document.querySelector("main").appendChild(mensaje);
});
