package com.interAudio.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import com.interAudio.service.ProductoService;

@Controller
@RequestMapping("/productos")
public class ProductosController {

    @Autowired
    private ProductoService productoService;

    @GetMapping("/index")
    public String mostrarIndex(Model model) {
        model.addAttribute("productos", productoService.obtenerTodosProductos());
        return "productos/catalogo";
    }
}