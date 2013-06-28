<?php
$category_num = 0;
if(isset($_REQUEST['cate'])){
	if(in_array(intval($_REQUEST['cate']), array(0,1,2,3,4))){
		$category_num = intval($_REQUEST['cate']);
	}
}
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>产品展示</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script src="http://yui.yahooapis.com/3.4.1/build/yui/yui-min.js"></script>
<!--global js varibles-->
<script type="text/javascript">
var pageTotal=3; // 3 is the page number, if more than 3 pages, change it;
</script>
<link rel=stylesheet href="css/global.css" />
<link rel=stylesheet href="css/body_product.css" />
</head>
<body>
<?php require("header.php"); ?>
<div id='categories'>
	<ul>
		<li class="category<?php if($category_num===0) echo ' cur_category';?>"><a href="javascript:void(0)" title="名家名作" >名家瓷</a></li>
		<li class="category<?php if($category_num===1) echo ' cur_category';?>"><a href="javascript:void(0)" title="仿古瓷" >仿古瓷</a></li>
		<li class="category<?php if($category_num===2) echo ' cur_category';?>"><a href="javascript:void(0)" title="艺术陈设瓷" >艺术陈设瓷</a></li>
		<li class="category<?php if($category_num===3) echo ' cur_category';?>"><a href="javascript:void(0)" title="高档日用瓷" >高档日用瓷</a></li>
		<li class="category<?php if($category_num===4) echo ' cur_category';?>"><a href="javascript:void(0)" title="定点外销瓷" >定点外销瓷</a></li>
	</ul>
</div>
<div id="body_product_main">
<div class="left_pointer has_border"></div>
<div id="products_stage">
	<div id="page_select_div">
		<span>第</span>
		<select id="page_select">
			<option value="0" selected="selected">1</option>
			<option value="1" >2</option>
			<option value="2" >3</option>
		</select>
		<span>页</span>
	</div>
	<div class="products_wrapper" id="page0">
		<div class="product_element"><div class="product_img"><img alt="产品图片" src="resource/product6.jpg" /></div><div class="product_desc"><p>产品名称:</p><p>价格:￥1000</p></div></div>
		<div class="product_element"><div class="product_img"><img alt="产品图片" src="resource/product5.jpg" /></div><div class="product_desc"><p>产品名称:</p><p>价格:￥1000</p></div></div>
		<div class="product_element"><div class="product_img"><img alt="产品图片" src="resource/product4.jpg" /></div><div class="product_desc"><p>产品名称:</p><p>价格:￥1000</p></div></div>
		<div class="product_element"><div class="product_img"><img alt="产品图片" src="resource/product3.jpg" /></div><div class="product_desc"><p>产品名称:</p><p>价格:￥1000</p></div></div>
		<div class="product_element"><div class="product_img"><img alt="产品图片" src="resource/product2.jpg" /></div><div class="product_desc"><p>产品名称:</p><p>价格:￥1000</p></div></div>
		<div class="product_element"><div class="product_img"><img alt="产品图片" src="resource/product1.jpg" /></div><div class="product_desc"><p>产品名称:</p><p>价格:￥1000</p></div></div>
	</div>
	<div class="products_wrapper hid_wrapper" id="page1">
		<div class="product_element"><div class="product_img"><img alt="产品图片" src="resource/product4.jpg" /></div><div class="product_desc"><p>产品名称:</p><p>价格:￥1000</p></div></div>
		<div class="product_element"><div class="product_img"><img alt="产品图片" src="resource/product2.jpg" /></div><div class="product_desc"><p>产品名称:</p><p>价格:￥1000</p></div></div>
		<div class="product_element"><div class="product_img"><img alt="产品图片" src="resource/product3.jpg" /></div><div class="product_desc"><p>产品名称:</p><p>价格:￥1000</p></div></div>
		<div class="product_element"><div class="product_img"><img alt="产品图片" src="resource/product5.jpg" /></div><div class="product_desc"><p>产品名称:</p><p>价格:￥1000</p></div></div>
		<div class="product_element"><div class="product_img"><img alt="产品图片" src="resource/product6.jpg" /></div><div class="product_desc"><p>产品名称:</p><p>价格:￥1000</p></div></div>
		<div class="product_element"><div class="product_img"><img alt="产品图片" src="resource/product1.jpg" /></div><div class="product_desc"><p>产品名称:</p><p>价格:￥1000</p></div></div>
	</div>
	<div class="products_wrapper hid_wrapper" id="page2">
		<div class="product_element"><div class="product_img"><img alt="产品图片" src="resource/product1.jpg" /></div><div class="product_desc"><p>产品名称:</p><p>价格:￥1000</p></div></div>
		<div class="product_element"><div class="product_img"><img alt="产品图片" src="resource/product2.jpg" /></div><div class="product_desc"><p>产品名称:</p><p>价格:￥1000</p></div></div>
		<div class="product_element"><div class="product_img"><img alt="产品图片" src="resource/product3.jpg" /></div><div class="product_desc"><p>产品名称:</p><p>价格:￥1000</p></div></div>
		<div class="product_element"><div class="product_img"><img alt="产品图片" src="resource/product4.jpg" /></div><div class="product_desc"><p>产品名称:</p><p>价格:￥1000</p></div></div>
		<div class="product_element"><div class="product_img"><img alt="产品图片" src="resource/product5.jpg" /></div><div class="product_desc"><p>产品名称:</p><p>价格:￥1000</p></div></div>
		<div class="product_element"><div class="product_img"><img alt="产品图片" src="resource/product6.jpg" /></div><div class="product_desc"><p>产品名称:</p><p>价格:￥1000</p></div></div>
	</div>
</div>
<div class="right_pointer has_border"></div>
</div>
<?php require("footer.php"); ?>
<form id="argu_form" method="get" action="product.php">
<input type="hidden" id="cate" name="cate" value="" />
</form>
<script src="js/product.js"></script>
</body>
</html>

