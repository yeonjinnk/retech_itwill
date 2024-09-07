package com.itwillbs.retech_proj.service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.itwillbs.retech_proj.vo.ProductVO;

@Repository
public class MainProductRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;  // Autowire JdbcTemplate

    // 최근 업데이트 상품 불러오기
    public List<ProductVO> findRecentProducts() {
        String sql = "SELECT pd_idx, member_id, pd_subject, pd_image1 FROM product ORDER BY pd_first_date DESC LIMIT 3";
        return jdbcTemplate.query(sql, new RowMapper<ProductVO>() {
            @Override
            public ProductVO mapRow(ResultSet rs, int rowNum) throws SQLException {
                ProductVO product = new ProductVO();
                product.setPd_idx(rs.getInt("pd_idx"));
                product.setMember_id(rs.getString("member_id"));
                product.setPd_subject(rs.getString("pd_subject"));
                product.setPd_image1(rs.getString("pd_image1"));
                return product;
            }
        });
    }
    
    // 인기 상품 불러오기
    public List<ProductVO> findPopularProducts() {
        String sql = "SELECT p.pd_idx, p.member_id, p.pd_subject, p.pd_image1 " +
                     "FROM product p " +
                     "INNER JOIN (SELECT pd_idx FROM likes GROUP BY pd_idx ORDER BY COUNT(pd_idx) DESC LIMIT 3) AS top_liked_products " +
                     "ON p.pd_idx = top_liked_products.pd_idx";
        return jdbcTemplate.query(sql, new RowMapper<ProductVO>() {
            @Override
            public ProductVO mapRow(ResultSet rs, int rowNum) throws SQLException {
                ProductVO product = new ProductVO();
                product.setPd_idx(rs.getInt("pd_idx"));
                product.setMember_id(rs.getString("member_id"));
                product.setPd_subject(rs.getString("pd_subject"));
                product.setPd_image1(rs.getString("pd_image1"));
                return product;
            }
        });
        
        
    }
}