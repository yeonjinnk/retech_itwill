package com.itwillbs.retech_proj.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.security.access.method.P;

import com.itwillbs.retech_proj.vo.LikeVO;
import com.itwillbs.retech_proj.vo.ProductVO;


@Mapper
public interface ProductMapper {
	
	//상품 등록 처리
	int insertProduct(ProductVO product);
	
	//상품 목록 조회 요청
	List<ProductVO> selectProductList(int startRow, int listLimit);
	
	//상품 목록 개수조회 요청(페이징처리)
	int selectProductListCount();
	
	//선택한 카테고리와 거래상태에 해당하는 상품리스트 가져오기
	
	List<ProductVO> selectSelectedProductList(@Param("pd_category") String pd_category, @Param("pd_status") String pd_status);
	
	//정렬변경시 정렬변경된 중고상품 목록 조회 요청 
	List<HashMap<String, String>> selectChangedProductList(@Param("pageNum") int pageNum,
														   @Param("pd_category")String pd_category, 
														   @Param("pd_selectedManufacturer") String pd_selectedManufacturer, 
														   @Param("pd_selectedPdStatus") String pd_selectedPdStatus, 
														   @Param("sort") String sort,
														   @Param("endRow") int endRow,
														   @Param("startRow") int startRow,
														   @Param("listLimit") int listLimit);
	// 정렬변경시 정렬변경된 중고상품 목록개수 조회 요청
	int selectChangedProductListCount(@Param("pageNum") int pageNum, 
									  @Param("pd_category") String pd_category, 
									  @Param("pd_selectedManufacturer") String pd_selectedManufacturer, 
									  @Param("pd_selectedPdStatus") String pd_selectedPdStatus, 
									  @Param("sort") String sort, 
									  @Param("type") String type
									 );
	//카테고리 리스트 조회 요청
	List<HashMap<String, String>> selectCategoryList();
	

//		//리테크 상품 수정
//		int updateProduct(ProductVO product);

	// 상품 거래 상태 업데이트
	int updateProductStatus(@Param("pd_idx") int pd_idx, 
							@Param("pd_status") String pd_status);

	// 상품 상세정보
	ProductVO selectProductById(int pd_Idx);
	
	// 상품번호에 해당하는 상품의 상세정보조회 요청
	ProductVO selectProduct(int pd_idx);
	
	// 상품 상세정보 조회 -> 조회수증가작업 (update)
	void updateReadCount(ProductVO product);
	
	// 상품 번호 memeber_id에 해당하는 판매자 정보 조회 요청
	HashMap<String, String> selectSellerInfo(@Param("pd_idx")int pd_idx,
											 @Param("member_id")String member_id);
	// 판매자의 판매물품 개수 조회요청
	int selectSellerProductCount(String member_id);
	
	
	// 판매자의 판매물품 리스트 조회요청
	List<HashMap<String, String>> selectSellerProductList(String member_id);
	
	//상품수정
	int updateProduct(ProductVO product);
	//끌어올리기
	int updateDate(int pd_idx);
	//글 삭제 작업
	int deleteProduct(int pd_idx);
	//찜 목록 보여주기
	List<HashMap<String, String>> selectLikeProduct(String member_id);
	//찜등록 기능
	int insertLikeProduct(LikeVO productLike);
	//찜하기 취소 기능
	int deleteLikeProduct(LikeVO productLike);
	
	

}
