<?php
require("env.php");
?>
<html>
<head>
<script type="text/javascript">
function get_token(){
	get_token_url = "https://api.weibo.com/oauth2/authorize?client_id="
						 + <?php echo '"'.APP_KEY.'"';?>
						 + "&response_type=code&redirect_uri="
						 + <?php echo '"'.REGISTERED_REDIRECT_URI.'"';?>;
	window.location.href = get_token_url;
}
</script>
<title>test_get_token</title>
</head>
<body>
<input type="button" onclick="javascript:get_token();" value="get token" />
</body>
</html>
