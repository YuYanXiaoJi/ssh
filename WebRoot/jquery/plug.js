/*
 * 对文字的控制
 */

(function($){
	$.fn.moreText = function(options){
		var defaults = {
			/*maxLength:1300,
			mainCell:".branddesc",*/
			openBtn:'显示全部',
			closeBtn:'收起'
		};
		return this.each(function() {
			var _this = $(this);
			
			var opts = $.extend({},defaults,options);
			var maxLength = opts.maxLength;
			var TextBox = $(opts.mainCell,_this);
			var openBtn = opts.openBtn;
			var closeBtn = opts.closeBtn;
			
			var countText = TextBox.html();
			var newHtml = '';
			if(countText.length > maxLength){
				newHtml = countText.substring(0,maxLength);
				//进行正则表达处理
				var re1 =  /[\u4e00-\u9fa5]{2,}/g;
				newHtml =  newHtml.match(re1) +'......<span class="more"><a href="javascript:void(0)">'+openBtn+'</a></span>';
				
			}else{
				newHtml = countText;
			}
			TextBox.html(newHtml);
			TextBox.on("click",".more",function(){
				if($(this).text()==openBtn){
					TextBox.html(countText+' &nbsp;&nbsp;&nbsp;&nbsp;<span class="more"><a href="javascript:void(0)">'+closeBtn+'</a></span>');
				}else{
					TextBox.html(newHtml);
				}
			});
		});
	};
})(jQuery);