var Informer = {

	getData: function(user, css)
	{
		if(user === undefined)
		{
			return;
		}
		
		var informerDOM = jQuery("#fgr-informer");
		
		$.ajax({
			dataType: 'jsonp',
			crossDomain: true,
			url: 'http://localhost:3000/games/informer.js',
			success: function(data){ alert('success'); }
		});
	},
	
	// форумный информер
	// username - форумный логин пользователя
	// css - опциональный параметр. Отвечает за стиль элемента #fgr-informer, когда у пользователя есть новые игры.
	// Задается в виде объекта: {'color': 'red'}
	// Если undefined, применяется стиль: {'font-weight': 'bold'}
	// Чтобы не применять никакой стиль, нужно передать пустой объект: {}
	forum: function(username, css)
	{
		if(!username)
		{
			return;
		}
		this.getData({forum_user: username}, css);
	},
	
	// блоговый информер. Отличается от форумного только именем передаваемого параметра
	blog: function(username, css)
	{
		if(!username)
		{
			return;
		}
		this.getData({blog_user: username}, css);
	}
};
