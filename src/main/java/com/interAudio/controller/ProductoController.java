package com.interAudio.controller;

import com.interAudio.entity.Producto;
import com.interAudio.service.ProductoService;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/productos")
public class ProductoController {

    private final ProductoService productoService;

    public ProductoController(ProductoService productoService) {
        this.productoService = productoService;
    }

    @GetMapping
    public String listarProductos(Model model) {
        model.addAttribute("productos", productoService.obtenerTodos());
        return "productos/lista"; 
    }

    @GetMapping("/catalogo") // Mapea la URL /productos/catalogo
    public String mostrarCatalogo(Model model) {
        List<Producto> productos = productoService.obtenerTodos();
        model.addAttribute("productos", productos);
        return "productos/catalogo";
    }

    @GetMapping("/detallesproductos/{id}")
    public String verDetalleProducto(@PathVariable Long id, Model model) {
        Optional<Producto> producto = productoService.obtenerPorId(id);
        if (producto.isPresent()) {
            model.addAttribute("producto", producto.get());
            return "productos/detallesproductos";
        } else {
            return "redirect:/productos";
        }
    }
    
    @GetMapping("/nosotros")
    public String mostrarNosotros() {
        return "navegacion/nosotros";
    }

    @GetMapping("/instalaciones")
    public String mostrarInstalaciones() {
        return "navegacion/instalaciones";
    }

}
