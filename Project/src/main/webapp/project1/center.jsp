<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- JSTL 전체라이브러리에 속한 core에 속한 태그들 사용을 위해  반드시 작성해야 하는 한줄 --%>   
<%@ taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
    
<% 
	request.setCharacterEncoding("UTF-8");  
	String contextPath = request.getContextPath();
%>        
    
<!DOCTYPE html>
<html>
<!DOCTYPE html>
<html lang="ko">

<body>
    <!-- [E]hooms-N54 -->
    <main class="th-layout-main">
      <!-- [S]hooms-N1 -->
      <div class="hooms-N1" data-bid="PZluHy5FHL">
        <div class="contents-container">
          <div class="contents-swiper">
            <div class="swiper-wrapper">
              <div class="swiper-slide">
                <img
                  class="contents-backimg img-pc"
                  src="../resources/images/img_mainvisual_01.png"
                  alt="배너 PC 이미지"
                />
                <img
                  class="contents-backimg img-mobile"
                  src="../resources/images/img_mainvisual_mobile_01.png"
                  alt="배너 모바일 이미지"
                />
                <div class="contents-slide-group">
                  <h2 class="contents-title">Inflearn</h2>
                  <p class="contents-text">
                    ㅋㅋ 존나 잘만듦 ㅇㅈ?  <br />
                    여기 대충 사이트 설명
                  </p>
                
                </div>
              </div>
              <div class="swiper-slide">
                <img
                  class="contents-backimg img-pc"
                  src="../resources/images/img_mainvisual_02.png"
                  alt="배너 PC 이미지"
                />
                <img
                  class="contents-backimg img-mobile"
                  src="../resources/images/img_mainvisual_mobile_02.png"
                  alt="배너 모바일 이미지"
                />
                <div class="contents-slide-group">
                  <h2 class="contents-title">HOOMS</h2>
                  <p class="contents-text">
                    훔스만의 독자적인 기술로 완성된 포켓스프링 <br />
                    흔들리지 않는 편안함, 그 아름다운 휴식 Beautyrest
                  </p>
                  <a class="contents-link" href="javascript:void(0)"
                    >Learn more</a
                  >
                </div>
              </div>
              <div class="swiper-slide">
                <img
                  class="contents-backimg img-pc"
                  src="../resources/images/img_mainvisual_03.png"
                  alt="배너 PC 이미지"
                />
                <img
                  class="contents-backimg img-mobile"
                  src="../resources/images/img_mainvisual_mobile_03.png"
                  alt="배너 모바일 이미지"
                />
                <div class="contents-slide-group">
                  <h2 class="contents-title">HOOMS</h2>
                  <p class="contents-text">
                    훔스만의 독자적인 기술로 완성된 포켓스프링 <br />
                    흔들리지 않는 편안함, 그 아름다운 휴식 Beautyrest
                  </p>
                  <a class="contents-link" href="javascript:void(0)"
                    >Learn more</a
                  >
                </div>
              </div>
            </div>
            <div class="swiper-button-next"></div>
            <div class="swiper-button-prev"></div>
            <div class="contents-control">
              <div class="swiper-pagination"></div>
              <div class="swiper-button-pause">
                <img
                  src="../resources/icons/ico_pause.svg"
                  alt="스와이퍼 멈춤버튼"
                />
              </div>
              <div class="swiper-button-play">
                <img
                  src="../resources/icons/ico_play.svg"
                  alt="스와이퍼 재생버튼"
                />
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- [E]hooms-N1 -->
      <!-- [S]hooms-N3 -->
      <div class="hooms-N3" data-bid="GVluhY5fMl" id=""></div>
      <!-- [E]hooms-N3 -->
      <!-- [S]hooms-N4 -->
      <div class="hooms-N4" data-bid="rhluHY5FR1" id="">
        <div class="contents-container container-md">
          <ul class="contents-imglist">
            <li class="contents-imgitem">
              <img src="../resources/images/img_urban01_1.png" alt="이미지" />
            </li>
            <li class="contents-imgitem">
              <img src="../resources/images/img_urban01_2.png" alt="이미지" />
            </li>
          </ul>
          <div class="contents-right">
            <div class="textset textset-h2">
              <span class="textset-name">About us</span>
              <h2 class="textset-tit">
                THE JOEUN <br />
                INFLEARN DESIGN
              </h2>
            </div>
            <div class="contents-textgroup">
              <div class="textset">
                <p class="textset-desc">
                 ㅋㅋ 존나 잘만듦 ㅇㅈ?  <br />
                    여기 대충 사이트 설명
                </p>
                <p class="textset-desc">
                  ㅋㅋ 존나 잘만듦 ㅇㅈ?  <br />
                    여기 대충 사이트 설명
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- [E]hooms-N4 -->
      <!-- [S]hooms-N6 -->
      <div class="hooms-N6" data-bid="CZLuHy5Fvo">
        <div class="contents-container container-md">
          <div class="contents-left">
            <div class="textset textset-h2">
              <span class="textset-name">Courses</span>
              <h2 class="textset-tit">스타강사 신상국 !!</h2>
            </div>
            <div class="textset">
              <p class="textset-desc">
                일단 들어봐  <br />
                jsp 들어봐 <br />
                엌ㅋㅋ <br />
                강의 설명
              </p>
              <a
                class="textset-link aboutus-imgitem btnset btnset-mono"
                href="javascript:void(0)"
              >
                View more
              </a>
            </div>
          </div>
          <div class="contents-right">
            <img
              src="../resources/images/img_product_01.png"
              alt="메인이미지"
            />
          </div>
        </div>
      </div>
      
      <div class="hooms-N6" data-bid="CZLuHy5Fvo">
        <div class="contents-container container-md">
          <div class="contents-left">
            <div class="textset textset-h2">
              <span class="textset-name">Courses</span>
              <h2 class="textset-tit">스타강사 신상국 !!</h2>
            </div>
            <div class="textset">
              <p class="textset-desc">
                일단 들어봐  <br />
                jsp 들어봐 <br />
                엌ㅋㅋ <br />
                강의 설명
              </p>
              <a
                class="textset-link aboutus-imgitem btnset btnset-mono"
                href="javascript:void(0)"
              >
                View more
              </a>
            </div>
          </div>
          <div class="contents-right">
            <img
              src="../resources/images/img_product_01.png"
              alt="메인이미지"
            />
          </div>
        </div>
      </div>
      <!-- [E]hooms-N6 -->
      <!-- [S]hooms-N5 -->
<!--       <div class="hooms-N5" data-bid="OILUhY5FZB" id=""></div> -->
<!--       [E]hooms-N5 -->
<!--       [S]hooms-N7 -->
<!--       <div class="hooms-N7" data-bid="jGLUhY5G6l"> -->
<!--         <div class="contents-inner"> -->
<!--           <div class="contents-container container-md"> -->
<!--             <div class="textset textset-h2"> -->
<!--               <span class="textset-name">Shop</span> -->
<!--               <h2 class="textset-tit"> -->
<!--                 HOOMS <br /> -->
<!--                 SELECTION -->
<!--               </h2> -->
<!--             </div> -->
<!--             <div class="contents-swiper"> -->
<!--               <div class="swiper-wrapper contents-wrapper"> -->
<!--                 <div class="swiper-slide contents-slide"> -->
<!--                   <a class="contents-link" href="javascript:void(0)"> -->
<!--                     <div class="contents-productimg"> -->
<!--                       <img -->
<!--                         src="../resources/images/img_shop_01_1.png" -->
<!--                         alt="이미지" -->
<!--                       /> -->
<!--                     </div> -->
<!--                     <div class="contents-price"> -->
<!--                       Clear Blue Color Set <span>2,000,000</span> -->
<!--                     </div> -->
<!--                   </a> -->
<!--                 </div> -->
<!--                 <div class="swiper-slide contents-slide"> -->
<!--                   <a class="contents-link" href="javascript:void(0)"> -->
<!--                     <div class="contents-productimg"> -->
<!--                       <img -->
<!--                         src="../resources/images/img_shop_01_2.png" -->
<!--                         alt="이미지" -->
<!--                       /> -->
<!--                     </div> -->
<!--                     <div class="contents-price"> -->
<!--                       Clear Blue Color Set <span>2,000,000</span> -->
<!--                     </div> -->
<!--                   </a> -->
<!--                 </div> -->
<!--                 <div class="swiper-slide contents-slide"> -->
<!--                   <a class="contents-link" href="javascript:void(0)"> -->
<!--                     <div class="contents-productimg"> -->
<!--                       <img -->
<!--                         src="../resources/images/img_shop_01_3.png" -->
<!--                         alt="이미지" -->
<!--                       /> -->
<!--                     </div> -->
<!--                     <div class="contents-price"> -->
<!--                       Clear Blue Color Set <span>2,000,000</span> -->
<!--                     </div> -->
<!--                   </a> -->
<!--                 </div> -->
<!--               </div> -->
<!--             </div> -->
<!--             <div class="swiper-pagination container-md"></div> -->
<!--           </div> -->
<!--         </div> -->
<!--       </div> -->
<!--       [E]hooms-N7 -->
<!--       [S]hooms-N8 -->
<!--       <div class="hooms-N8" data-bid="BZluHy5gdS" id=""></div> -->
      <!-- [E]hooms-N8 -->
    </main>


</body>
</html>























