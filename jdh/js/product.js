YUI().use('node', 'transition', function(Y){
	var cTotal=5,cIter,curPage=0,pTotal=pageTotal,curOpt;
	var nodeSel=Y.one('#page_select');
	var optList=nodeSel.all('option');
	var cList=Y.all('.category');
	var nodeL=Y.one('.left_pointer');
	var nodeR=Y.one('.right_pointer');
	function checkPointerDisp(){
		if(curPage===0){
			if(!nodeL.hasClass('non_display')){
				nodeL.addClass('non_display');
			}
			if(nodeR.hasClass('non_display')){
				nodeR.removeClass('non_display');
			}
		}else if(curPage===pTotal-1){
			if(!nodeR.hasClass('non_display')){
				nodeR.addClass('non_display');
			}
			if(nodeL.hasClass('non_display')){
				nodeL.removeClass('non_display');
			}
		}else{
			if(nodeL.hasClass('non_display')){
				nodeL.removeClass('non_display');
			}
			if(nodeR.hasClass('non_display')){
				nodeR.removeClass('non_display');
			}
		}
	}
	function setSelOpt(){
		optList.each(function(nodeOpt){
			isSelected=nodeOpt.get('selected');
			optVal=parseInt(nodeOpt.get('value'));
			if(optVal==curPage){
				nodeOpt.set('selected', 'selected');
			}
		});
	}
	function removeBorder(e){
		e.target.removeClass('has_border');
	}
	function addBorder(e){
		e.target.addClass('has_border');
	}
	function previousPageMain(e){
		if(curPage===0){
			return;
		}
		curNode=Y.one('#page'+curPage);
		preNode=Y.one('#page'+(curPage-1));
		preNode.setStyle('left', '-1000px');
		preNode.removeClass('hid_wrapper');
		curNode.transition({duration:0.5,left:'1000px',opacty:0});
		preNode.transition({duration:0.5,left:'0px',opacty:1});
		curNode.addClass('hid_wrapper');
	}
	function previousPage(e){
		previousPageMain(e);
		curPage--;
		checkPointerDisp();
		setSelOpt();
	}
	function nextPageMain(e){
		if(curPage===pTotal-1){
			return;
		}
		curNode=Y.one('#page'+curPage);
		nextNode=Y.one('#page'+(curPage+1));
		nextNode.setStyle('left', '1000px');
		nextNode.removeClass('hid_wrapper');
		curNode.transition({duration:0.5,left:'-1000px',opacty:0});
		nextNode.transition({duration:0.5,left:'0px',opacty:1});
		curNode.addClass('hid_wrapper');
	}
	function nextPage(e){
		nextPageMain(e);
		curPage++;
		checkPointerDisp();
		setSelOpt();
	}
	function switchPage(e){
		optList.each(function(nodeOpt){
			if(nodeOpt.get('selected')){
				curOpt=parseInt(nodeOpt.get('value'));
			}
		});
		if(curOpt>curPage){
			nextPageMain(e);
			curPage=curOpt;
		}else if(curOpt<curPage){
			previousPageMain(e);
			curPage=curOpt;
		}
		checkPointerDisp();
	}

	for(cIter=0;cIter<cTotal;cIter++){
		cList.item(cIter).on('click', function(cIter){
			return function(e){
				Y.one('#cate').set('value',cIter);
				Y.one('#argu_form').submit();
			}
		}(cIter));
	}
	checkPointerDisp();
	nodeL.on('mouseover', removeBorder);
	nodeL.on('mouseout', addBorder);
	nodeL.on('click', previousPage);
	nodeR.on('mouseover', removeBorder);
	nodeR.on('mouseout', addBorder);
	nodeR.on('click', nextPage);
	nodeSel.on('change', switchPage);
})
