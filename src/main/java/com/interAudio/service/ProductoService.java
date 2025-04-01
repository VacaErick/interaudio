package com.interAudio.service;

import com.interAudio.entity.Producto;
import com.interAudio.repository.ProductoRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class ProductoService {

    private final ProductoRepository productoRepository;

    public ProductoService(ProductoRepository productoRepository) {
        this.productoRepository = productoRepository;
    }

    public List<Producto> obtenerTodos() {
        return productoRepository.findAll();
    }

    public Producto buscarPorId(Long id) {
        return productoRepository.findById(id).orElse(null);
    }

    public Producto buscarConCategoria(Long id) {
        return productoRepository.findProductoConCategoria(id);
    }

    public List<Producto> productosRelacionados(Long idProducto) {
        Producto producto = buscarConCategoria(idProducto);
        return productoRepository.findRelacionadosPorCategoria(
                producto.getCategoria().getId(),
                idProducto);
    }

    public void guardar(Producto producto) {
        productoRepository.save(producto);
    }

    public void eliminar(Long id) {
        productoRepository.deleteById(id);
    }

    public Optional<Producto> obtenerPorId(Long id) {
        return productoRepository.findById(id);
    }

}