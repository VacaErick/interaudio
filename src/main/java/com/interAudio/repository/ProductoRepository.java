package com.interAudio.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import com.interAudio.entity.Producto;

public interface ProductoRepository extends JpaRepository<Producto, Long> {

    
    @Query("SELECT p FROM Producto p LEFT JOIN FETCH p.categoria WHERE p.id = :id")
    Producto findProductoConCategoria(@Param("id") Long id);

    @Query("SELECT p FROM Producto p WHERE p.categoria.id = :idCategoria AND p.id != :excluirId ORDER BY RAND() LIMIT 4")
    List<Producto> findRelacionadosPorCategoria(
            @Param("idCategoria") Long idCategoria,
            @Param("excluirId") Long idProducto);
}