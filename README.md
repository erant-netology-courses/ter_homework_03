# ter_homework_03

## Задание 1
<img width="1280" height="360" alt="image" src="https://github.com/erant-netology-courses/ter_homework_03/blob/main/1.JPG?raw=true" />

## Задание 4
Все делаю в отдельных репах, поэтому без ветки как в тз. Пользоваться гитом умею, если что))

<img width="1280" height="360" alt="image" src="https://github.com/erant-netology-courses/ter_homework_03/blob/main/4.JPG?raw=true" />

## Задание 5*
<img width="1280" height="360" alt="image" src="https://github.com/erant-netology-courses/ter_homework_03/blob/main/5.JPG?raw=true" />

## Задание 6*
Не делал, т.к. не вижу смысла манки-кодить что то в ансибл, с которым еще не было обучения, без глубокого понимания.

## Задание 7*
```
merge(local.vpc, {
  subnet_ids   = [for i, v in local.vpc.subnet_ids : v if i != 2]
  subnet_zones = [for i, v in local.vpc.subnet_zones : v if i != 2]
})
```

## Задание 8*
Фигурная скобка и пробел

`${i["name"]} ansible_host=${i["network_interface"][0]["nat_ip_address"]} platform_id=${i["platform_id"]}`

## Задание 9*
```
1 - [for i in range(1, 100) : format("rc%02d", i)]
2 - [for i in range(1, 97) : format("rc%02d", i)  if (i % 10 != 0 && i % 10 != 7 && i % 10 != 8 && i % 10 != 9) || i == 19]
```
