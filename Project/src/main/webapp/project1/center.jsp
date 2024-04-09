<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%-- JSTL 전체라이브러리에 속한 core에 속한 태그들 사용을 위해  반드시 작성해야 하는 한줄 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
							<img class="contents-backimg img-pc"
								src="../resources/images/img_mainvisual_01.png" alt="배너 PC 이미지" />
							<img class="contents-backimg img-mobile"
								src="../resources/images/img_mainvisual_mobile_01.png"
								alt="배너 모바일 이미지" />
							<div class="contents-slide-group">
								<h2 class="contents-title">Inflearn</h2>
								<p class="contents-text">우리는 때로 무언가를 배워야만 합니다.</p>
								<br> <a
									class="textset-link aboutus-imgitem btnset btnset-mono"
									href="<%=contextPath%>/users/aboutus"> ABOUT US </a>
							</div>
						</div>
						<div class="swiper-slide">
							<img class="contents-backimg img-pc"
								src="../resources/images/img_mainvisual_02.png" alt="배너 PC 이미지" />
							<img class="contents-backimg img-mobile"
								src="../resources/images/img_mainvisual_mobile_02.png"
								alt="배너 모바일 이미지" />
							<div class="contents-slide-group">
								<h2 class="contents-title">HOOMS</h2>
								<p class="contents-text">
									훔스만의 독자적인 기술로 완성된 포켓스프링 <br /> 흔들리지 않는 편안함, 그 아름다운 휴식
									Beautyrest
								</p>
								<a class="contents-link" href="javascript:void(0)">Learn
									more</a>
							</div>
						</div>
						<div class="swiper-slide">
							<img class="contents-backimg img-pc"
								src="../resources/images/img_mainvisual_03.png" alt="배너 PC 이미지" />
							<img class="contents-backimg img-mobile"
								src="../resources/images/img_mainvisual_mobile_03.png"
								alt="배너 모바일 이미지" />
							<div class="contents-slide-group">
								<h2 class="contents-title">HOOMS</h2>
								<p class="contents-text">
									훔스만의 독자적인 기술로 완성된 포켓스프링 <br /> 흔들리지 않는 편안함, 그 아름다운 휴식
									Beautyrest
								</p>
								<a class="contents-link" href="javascript:void(0)">Learn
									more</a>
							</div>
						</div>
					</div>
					<div class="swiper-button-next"></div>
					<div class="swiper-button-prev"></div>
					<div class="contents-control">
						<div class="swiper-pagination"></div>
						<div class="swiper-button-pause">
							<img src="../resources/icons/ico_pause.svg" alt="스와이퍼 멈춤버튼" />
						</div>
						<div class="swiper-button-play">
							<img src="../resources/icons/ico_play.svg" alt="스와이퍼 재생버튼" />
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
					<li class="contents-imgitem"><img
						src="../resources/images/img_urban01_1.png" alt="이미지" /></li>
					<li class="contents-imgitem"><img
						src="../resources/images/img_urban01_2.png" alt="이미지" /></li>
				</ul>
				<div class="contents-right">
					<div class="textset textset-h2">
						<span class="textset-name">About us</span>
						<h2 class="textset-tit">인프런의 약속</h2>
					</div>
					<div class="contents-textgroup">
						<div class="textset">
							<p class="textset-desc">전문성 수년~십수년씩 커리어를 쌓고 노력해온 지식공유자들이 지식과
								노하우를 공유합니다. 당장 좋은 사수가 없거나, 교육을 받지 못하더라도 걱정하지 마세요. 인프런에서 전문가들에게서
								지식과 노하우를 배울 수 있습니다.</p>
							<p class="textset-desc">마케팅보다는 좋은 콘텐츠 마케팅보다는 좋은 콘텐츠에 집중합니다.
								좋지 않은 콘텐츠라도 홍보와 포장을 통해 이윤을 남길 수 있지만, 우리는 콘텐츠에 집중합니다. 좋은 콘텐츠를 통해
								자연스럽게 알려지고, 소개하게 되어 모두 함께 성장하는 공간을 만들겠습니다.</p>
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
						<h4 class="textset-tit">배민 김영한!</h4>
					</div>
					<div class="textset">
						<p class="textset-desc">인프런에서 가장 많은 유저가 학습한 최고의 로드맵, 대망의 완결!
							진짜 스프링 노하우를 알려드립니다. 실제로 현업에서 쓰이는 스프링 개발은 어때야 할까요? 우아한형제들 최연소
							기술이사로 일하며 스프링으로 조 단위의 거래 금액을 처리하는 수많은 시스템을 설계하고, 개발하는 데 쓰인 진짜 스프링
							노하우를 전수해드립니다. 실제 현업에서 사용하는 핵심 스프링을 중심으로, 실무에서 쓰이지 않거나 오래된 기능은
							과감하게 생략한 실무 노하우를 학습할 수 있습니다.</p>
						<a class="textset-link aboutus-imgitem btnset btnset-mono"
							href="<%=contextPath%>/RoadMap/"> View more </a>
					</div>
				</div>
				<div class="contents-right">
					<img src="../resources/images/img_product_01.png" alt="메인이미지" />
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
							일단 들어봐 <br /> jsp 들어봐 <br /> 엌ㅋㅋ <br /> 강의 설명
						</p>
						<a class="textset-link aboutus-imgitem btnset btnset-mono"
							href="javascript:void(0)"> View more </a>
					</div>
				</div>
				<div class="contents-right">
					<img src="../resources/images/img_product_01.png" alt="메인이미지" />
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























