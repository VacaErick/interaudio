package com.interAudio.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.interAudio.entity.Producto;

@Service
public interface ProductoService {
    @Override
    List<Producto> obtenerTodosProductos();
}