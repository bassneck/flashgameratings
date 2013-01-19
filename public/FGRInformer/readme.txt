Информер FlashGameRatings.ru v.1.0

Информер тестировался с jQuery 1.7.1 в браузерах Chrome 15.0.874.121, Firefox 3.6/8.0, Opera 11.60, IE 9


Использование информера:

1. Добавить на страницу элемент с id="fgr-informer":

<a id="fgr-informer" href="http://flashgameratings.ru">FlashGameRatings</a>

2. подключить jquery и скрипт информера:

так: <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
или так: <script type="text/javascript" src="jquery-1.7.1.min.js"></script>

<script type="text/javascript" src="fgr-informer.min.js"></script>

3. После загрузки страницы, вызвать функцию Informer.forum(%username%) или Informer.blog(%username%)

<script type="text/javascript">
$(document).ready(function(){
	Informer.forum(<?= $currentUser->username ?>);
});
</script>

При успешном выполнении запроса, к #fgr-informer будет дописано количество новых для пользователя игр: FlashGameRatings (3).
Если запрос по каким-то причинам не прошел (указан неправильный юзернейм, сервер недоступен и т.д.), элемент никак не изменяется.

4. Вторым параметром обе функции принимают css-стиль элемента #fgr-informer, который устанавливается, если есть новые игры:

Informer.forum(<?= $currentUser->username; ?>, {'color':'red'});

По умолчанию, задается стиль font-weight:bold. Чтобы стиль не менялся, можно передать пустой объект: {}.
Также, если сервер вернул больше одной игры, к элементу добавляется класс ".fgr-new-games".


PS. Есть непонятный баг, который не удается отловить: иногда Firefox 8 не отправляет запрос (вероятно, проблема в jQuery или самом Firefox). 
На работоспособности страницы это не сказывается, но и данные с FGR к ссылке не добавляются. 