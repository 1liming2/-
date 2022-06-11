#!/bin/bash
#-------------------------------------------------------------------------------
#黎明 2022.3.19           
#2022.4.10日更新
#这是第五次更新
#新增 输入玩家id和跳世界前的存档自动将玩家数据覆盖到跳之前的世界
#在小休和safethief的不断努力下，终于从初撤大佬那搞到了修复下载模组bug办法（NB）
#-------------------------------------------------------------------------------
gamesPath="Steam/steamapps/common/Don't Starve Together Dedicated Server/bin"
gamesFile="./dontstarve_dedicated_server_nullrenderer"
game="Steam/steamapps/common/Don't Starve Together Dedicated Server/mods/dedicated_server_mods_setup.lua"
function dimain()
{
cd $HOME
test=$(cat ./.klei/DoNotStarveTogether/Cluster_"$input_save"/Master/modoverrides.lua |grep '"workshop-' | cut -d '-' -f 2 | cut -d '"' -f1)
array=($test)
echo -e "\033[33m检测到${#array[@]}个模组\033[0m"
for((i=0;i<${#array[@]};i++))
	do
#	echo ${array[$i]}
if cat "$game" | grep "ServerModSetup("\"${array[$i]}\"")"
then
echo "此模组已下载" 
else 
echo "没有这个模组正在写入"
echo "ServerModSetup("\"${array[$i]}\"")" >> ./"$game"
fi
done
sleep 1
cd $HOME
cd "$gamesPath"
screen -dmS "地面 $input_save" "$gamesFile" -console -cluster Cluster_"$input_save" -shard Master
}
function dongxue()
{
cd $HOME
test=$(cat ./.klei/DoNotStarveTogether/Cluster_"$input_save"/Caves/modoverrides.lua |grep '"workshop-' | cut -d '-' -f 2 | cut -d '"' -f1)
array=($test)
echo -e "\033[33m检测到${#array[@]}个模组\033[0m"
for((i=0;i<${#array[@]};i++))
	do
#	echo ${array[$i]}
if cat "$game" | grep "ServerModSetup("\"${array[$i]}\"")"
then
echo "此模组已下载" 
else 
echo "没有这个模组正在写入"
echo "ServerModSetup("\"${array[$i]}\"")" >> ./"$game"
fi
done
sleep 1
cd $HOME
cd "$gamesPath"
screen -dmS "洞穴 $input_save" "$gamesFile" -console -cluster Cluster_"$input_save" -shard Caves
}
function yiqi()
{
cd $HOME
test=$(cat ./.klei/DoNotStarveTogether/Cluster_"$input_save"/Master/modoverrides.lua |grep '"workshop-' | cut -d '-' -f 2 | cut -d '"' -f1)
array=($test)
echo -e "\033[33m检测到${#array[@]}个模组\033[0m"
for((i=0;i<${#array[@]};i++))
	do
#	echo ${array[$i]}
if cat "$game" | grep "ServerModSetup("\"${array[$i]}\"")"
then
echo "此模组已下载" 
else 
echo "没有这个模组正在写入"
echo "ServerModSetup("\"${array[$i]}\"")" >> ./"$game"
fi
done
sleep 1
cd $HOME
cd "$gamesPath"
screen -dmS "地面 $input_save" "$gamesFile" -console -cluster Cluster_"$input_save" -shard Master
screen -dmS "洞穴 $input_save" "$gamesFile" -console -cluster Cluster_"$input_save" -shard Caves
}
function Startserver()
{  
	cd $HOME
	echo -e "\033[34m[提示] 启动 [1.地面] [2.洞穴] [3.地面+洞穴]\033[0m"
	read input_mode 
	echo -e "\033[34m[提示] 存档位 [1-5]\033[0m"
	read input_save
	if [ ! -d "./klei/DoNotStarveTogether/Cluster_"$input_save"" ]
	then 
		mkdir -p ./.klei/DoNotStarveTogether/Cluster_"$input_save"
	fi
	case $input_mode in  
		1)
			dimain;;
		2)
			dongxue;;
		3)
			yiqi;;
		*)
			echo -e "\033[31m[注意] Illegal Command,Please Check\033[0m" ;;
	esac
	Main
}
function announce()
{
  while (true)
  do
    clear
    echo -e "\e[31m提示：没有开启的档无法发送,按住ctrl+c即可退出公告\e[0m"
	echo -e "\e[34m请输入你要发送的公告内容，按下回车键发送：\e[0m"
    read an
    screen -S "地面 1" -X stuff "c_announce("\"$an\"")\n"
    sleep 1
  done
}
function huidang()
{
  while (true)
  do
    clear
	echo -e "\e[31m 按住ctrl+c即可退出回档\e[0m"
    echo -e "\e[31m提示：没有开启的档无法回档\e[0m"
    read Retreated
	txt="即将恢复到第$Retreated天前，请耐心等待"
	screen -S "地面 1" -X stuff "c_announce("\"$txt\"")\n"
	sleep 3
	screen -S "地面 1" -X stuff "c_rollback("\"$Retreated\"")\n"
    sleep 1
  done
}
function openMaster()
{
echo -e "\033[34m [提示] 存档位 [1-5] \033[0m"
cd $HOME
read num
echo "按住ctrl不松手再按a+d就可退出窗口"
sleep 2
screen -r "地面 $num"
}
function openCaves()
{
echo -e "\033[34m [提示] 存档位 [1-5] \033[0m"
cd $HOME
read num2
echo -e "\033[34m[提示] 存档位 [1-5] \033[0m"
echo "按住ctrl不松手再按a+d就可退出窗口"
sleep 2
screen -r "洞穴 $num2"
}
function openwh()
{
echo "按住ctrl不松手再按a+d就可退出窗口"
sleep 2
screen -r "自动维护"
}
function openwh2()
{
echo "按住ctrl不松手再按a+d就可退出窗口"
sleep 2
screen -r "半自动维护"
}
function jinru()
{
echo -e "\033[34m 输入：进程前的pid，如（7788.地面 1）输入7788   回车进入该窗口 \033[0m"
read pid1
screen -r $pid1
}
function CloseServer()
{
echo "============================================"
screen -ls
while :
do
echo -e "\033[34m快捷方式：1.地面 2.洞穴 ] [3.发送公告] [4.手动进入] [5.自动维护]
 [6.半自动维护] [7.回档] [0.返回菜单 \033[0m"
echo 
	read main2
		case $main2 in
			1)openMaster
			break;;
			2)openCaves
			break;;
			3)announce
			break;;
			4)jinru
			break;;
			5)openwh
			break;;
			6)openwh2
			break;;
			7)huidang
			break;;
			0)Main
			break;;	
		esac
done
}
function killMaster()
{
echo -e "\033[34m[提示] [提示] 存档位 [1-5] \033[0m"
read input_save
echo -e "\033[34m[提示] 地面正在关闭请稍等 \033[0m"
screen -S "地面 1" -X stuff "c_announce("\"地面世界服务器因改动或更新需要重启，预计耗时三分钟，给你带来的不便还请谅解！\"")\n"
screen -S "地面 1" -X stuff "c_save() \n"
sleep 5
pkill -f "地面 $input_save"
Main
}
function killCaves()
{
echo -e "\033[34m[提示] [提示] 存档位 [1-5] \033[0m"
read input_save2
echo -e "\033[34m[提示] 地面正在关闭请稍等 \033[0m"
screen -S "地面 1" -X stuff "c_announce("\"洞穴世界服务器因改动或更新需要重启，预计耗时三分钟，给你带来的不便还请谅解！\"")\n"
screen -S "洞穴 1" -X stuff "c_save() \n"
sleep 5
pkill -f "洞穴 $input_save2"
Main
}
function killss()
{
echo -e "\033[34m[提示] [提示] 存档位 [1-5] \033[0m"
read input_save3
echo -e "\033[34m[提示] 地面正在关闭请稍等 \033[0m"
screen -S "地面 1" -X stuff "c_announce("\"洞穴世界服务器因改动或更新需要重启，预计耗时三分钟，给你带来的不便还请谅解！\"")\n"
screen -S "洞穴 1" -X stuff "c_save() \n"
sleep 5
pkill -f "地面 $input_save3"
pkill -f "洞穴 $input_save3"
Main
}
function killallscreen()
{
echo -e "\033[34m[提示] 服务器正在关闭请稍等 \033[0m"
screen -S "地面 1" -X stuff "c_announce("\"所有世界服务器因改动或更新需要重启，预计耗时三分钟，给你带来的不便还请谅解！\"")\n"
screen -S "地面 1" -X stuff "c_save() \n"
sleep 5
killall screen
Main
}
function killprocess()
{
echo "============================================"
screen -ls
while :
do
echo -e "\033[34m 提示：[1.地面 2.洞穴 ] [3.地面+洞穴][4.全部关闭][0.返回菜单 \033[0m"
echo 
	read main2
		case $main2 in
			1)killMaster
			break;;
			2)killCaves
			break;;
			3)killss
			break;;			
			4)killallscreen
			break;;
			0)Main
			break;;	
		esac
done
}
function qidong()
{
	screen -ls |grep "自动维护" |grep -v grep
	if [ $? -ne 0 ]
	then
	cd $HOME
	chmod +x k.sh
	screen -dmS "自动维护" "./k.sh"
	else
	echo -e "\033[34m 提示：自动维护已开启不需要再次开启 \033[0m"
	sleep 2
	fi
	Startrestet
}
function close()
{
pkill -f 自动维护
sleep 3
Startrestet
}
function whgames()
{
	while :
	do
	echo 游戏更新:$whgamez
	echo 是否开启游戏更新 [1] 开启 [2] 关闭
	echo 
		read whgamess
			case $whgamess in
				1)whgam=true
				break;;
				2)whgam=false
				break;;
				*)
				echo 没有此选项请重新选择
			esac
	done
		sed -i "s/gameupdates=${whgame}/gameupdates=$whgam/g" k.sh
}
function whmods()
{
	while :
	do
	echo 模组更新:$whmodz
	echo 是否开启模组更新 [1] 开启 [2] 关闭
	echo 
		read whmodss
			case $whmodss in
				1)whmo=true
				break;;
				2)whmo=false
				break;;
				*)
				echo 没有此选项请重新选择
			esac
	done
		sed -i "s/modupdates=${whmod}/modupdates=$whmo/g" k.sh
}
function whzqs()
{
	while :
	do
	echo 异常自启:$whzqz
	echo 是否开启异常自启 [1] 开启 [2] 关闭
	echo 
		read whzqss
			case $whzqss in
				1)whz=true
				break;;
				2)whz=false
				break;;
				*)
				echo 没有此选项请重新选择
			esac
	done
		sed -i "s/game_selfstart=${whzq}/game_selfstart=$whz/g" k.sh
}
function mastww()
{
	echo 地面维护数量${mastw}
	echo 请输入修改的地面维护数量
	read numM
	sed -i "s/Masters=${mastw}/Masters=$numM/g" k.sh
}
function Cavtww()
{
	echo 洞穴维护数量${Cavtw}
	echo 请输入修改的洞穴维护数量
	read numC
	sed -i "s/Cavess=${Cavtw}/Cavess=$numC/g" k.sh
}
function whsz()
{
	cd $HOME
	whgame=$(cat k.sh |grep -o "gameupdates=.*"| awk -F"=" '{print $2}'|head -n 1)
	whmod=$(cat k.sh |grep -o "modupdates=.*"| awk -F"=" '{print $2}'|head -n 1)
	whzq=$(cat k.sh |grep -o "game_selfstart=.*"| awk -F"=" '{print $2}'|head -n 1)
	mastw=$(cat k.sh |grep -o "Masters=.*"| awk -F"=" '{print $2}'|head -n 1)
	Cavtw=$(cat k.sh |grep -o "Cavess=.*"| awk -F"=" '{print $2}'|head -n 1)
		if [[ ${whgame} == true ]];then
		whgamez="开启"
		elif [[ ${whgame} == false ]];then
			whgamez="关闭"
		fi
		if [[ ${whmod} == true ]];then
			whmodz="开启"
		elif [[ ${whmod} == false ]];then
			whmodz="关闭"
		fi
		if [[ ${whzq} == true ]];then
			whzqz="开启"
		elif [[ ${whzq} == false ]];then
			whzqz="关闭"
		fi		
	while :
		do
		echo [ 1]游戏更新：${whgamez}
		echo [ 2]模组更新：${whmodz}
		echo [ 3]异常自启：${whzqz}
		echo [ 4]地面数量：${mastw}
		echo [ 5]洞穴数量：${Cavtw}
		
		echo -e "\033[33m "[提示] 选择你要更改的选项,输入[0]退出 "\033[0m"
		echo 
			read main1
				case $main1 in
					1)whgames
					whsz
					break;;
					2)whmods
					whsz
					break;;
					3)whzqs
					whsz
					break;;
					4)mastww
					whsz
					break;;
					5)Cavtww
					whsz
					break;;
					0)Main
					break;;
				esac
		done
}
function Startrestet()
{
cd $HOME
	if [[ ! -f k.sh ]];then
	cat > k.sh <<-'EOF'
#!/bin/bash
#------------------------------------------------------------------------------
#黎明 2022.3.19                                                                     
#------------------------------------------------------------------------------

gamesPath="Steam/steamapps/common/Don't Starve Together Dedicated Server/bin"
gamesFile="./dontstarve_dedicated_server_nullrenderer"
game="Steam/steamapps/common/Don't Starve Together Dedicated Server/mods/dedicated_server_mods_setup.lua"
Masters=1
Cavess=1
game_selfstart=true
gameupdates=false
modupdates=false
function dim()
{
screen -dmS "地面 $sum" "$gamesFile" -console -cluster Cluster_"$sum" -shard Master
}
function dox()
{
screen -dmS "洞穴 $sum1" "$gamesFile" -console -cluster Cluster_"$sum1" -shard Caves 
}
function jiance()
{
cd $HOME
	new_game_version=$(curl -s 'https://forums.kleientertainment.com/game-updates/dst/' | grep 'data-currentRelease' | cut -d '/' -f6 | cut -d '-' -f1 | sort -r | head -n 1 | tr -cd '[0-9]' )
	cur_game_version=$(cat "Steam/steamapps/common/Don't Starve Together Dedicated Server/version.txt")
if [[ $cur_game_version != "" && $new_game_version != "" && $cur_game_version != $new_game_version ]]
	then
	echo "游戏版本不一样开始更新"
	echo "最新版本$new_game_version"
	echo "本地版本$cur_game_version"
	echo -e "\033[34m[提示] 服务器正在关闭请稍等 \033[0m"
	screen -S "地面 1" -X stuff "c_announce('所有世界服务器因改动或更新需要重启，预计耗时三分钟，给您带来的不便还请谅解！')\n"
	screen -S "地面 1" -X stuff "c_save() \n"
	echo -e "\033[34m 开始重新启动世界 \033[0m"
	sleep 5	
		pkill -f "地面"
		pkill -f "洞穴"
	cd ./steamcmd
	./steamcmd.sh +login anonymous +app_update 343050 validate +quit
	cd "$HOME"
	clear
	echo "更新完毕"
	shijie
	sleep 3
else 
	echo "没有游戏要更新正常运行"
	echo "最新版本$new_game_version"
	echo "本地版本$cur_game_version"
fi
}
function modupdate()
{
for((dimian=1;dimian<=$Masters;dimian++));do
cd $HOME
modlog="./.klei/DoNotStarveTogether/Cluster_$dimian/Master/server_chat_log.txt"
if cat "$modlog" | grep "is out of date and needs to be updated for new users to be able to join the server."
then
	echo "检测到新的模组开始更新！"
	echo -e "\033[34m[提示] 地面正在关闭请稍等 \033[0m"
	screen -S "地面 1" -X stuff "c_announce('地面$dimian世界服务器因改动或更新需要重启，预计耗时三分钟，给您带来的不便还请谅解！')\n"
	screen -S "地面 1" -X stuff "c_save() \n"
	echo -e "\033[34m 开始重新启动世界 \033[0m"
	sleep 5
		pkill -f "地面"
		pkill -f "洞穴"
	sleep 5
	shijie
else 
	echo "未检测到新的模组！游戏继续"
fi
done
for((dongxue=1;dongxue<=$Masters;dongxue++));do
cd $HOME
modlog="./.klei/DoNotStarveTogether/Cluster_$dongxue/Caves/server_chat_log.txt"
if cat "$modlog" | grep "is out of date and needs to be updated for new users to be able to join the server."
then
	echo "检测到新的模组开始更新！"
	echo -e "\033[34m[提示] 地面正在关闭请稍等 \033[0m"
	screen -S "地面 1" -X stuff "c_announce('洞穴$dongxue世界服务器因改动或更新需要重启，预计耗时三分钟，给您带来的不便还请谅解！')\n"
	screen -S "地面 1" -X stuff "c_save() \n"
	echo -e "\033[34m 开始重新启动世界 \033[0m"
	sleep 5
		pkill -f "地面"
		pkill -f "洞穴"
	sleep 5
	shijie
else 
	echo "未检测到新的模组！游戏继续"
	echo "开始检测世界是否正常运行"
fi
done
}
function shijie()
{
		for((i=0;i<$Masters;i++))
			do
			sum=1
			sum=`expr $sum + $i`
		screen -ls |grep "地面 $sum" |grep -v grep
		if [ $? -ne 0 ]
		then
		cd $HOME
				test=$(cat ./.klei/DoNotStarveTogether/Cluster_"$sum"/Master/modoverrides.lua |grep '"workshop-' | cut -d '-' -f 2 | cut -d '"' -f1)
				array=($test)
				echo -e "\033[33m检测到${#array[@]}个模组\033[0m"
				for((i=0;i<${#array[@]};i++))
					do
				#	echo ${array[$i]}
				if cat "$game" | grep "ServerModSetup('${array[$i]}')"
				then
				echo "此模组已下载" 
				else 
				echo "没有这个模组正在写入"
				echo "ServerModSetup('${array[$i]}')" >> ./"$game"
				fi
				done
				sleep 1
			cd $HOME
			cd "$gamesPath" 
			echo "检测到地面$sum异常开始重启"
			dim
		else
		echo "地面$sum正常运行"
		fi
		done
		for((k=0;k<$Cavess;k++))
			do
			sum1=1
			sum1=`expr $sum1 + $k`
		screen -ls |grep "洞穴 $sum1" |grep -v grep
		if [ $? -ne 0 ]
		then
		cd $HOME
			test=$(cat ./.klei/DoNotStarveTogether/Cluster_"$sum1"/Caves/modoverrides.lua |grep '"workshop-' | cut -d '-' -f 2 | cut -d '"' -f1)
			array=($test)
			echo -e "\033[33m检测到${#array[@]}个模组\033[0m"
			for((i=0;i<${#array[@]};i++))
				do
			#	echo ${array[$i]}
			if cat "$game" | grep "ServerModSetup('${array[$i]}')"
			then
			echo "此模组已下载" 
			else 
			echo "没有这个模组正在写入"
			echo "ServerModSetup('${array[$i]}')" >> ./"$game"
			fi
			done
			sleep 1
			cd $HOME
			cd "$gamesPath"
			echo -e "\033[34m"正在启动世界，按住ctrl不松手再按住a+d即可退出窗口"\033[0m"
			cd $HOME
			cd "$gamesPath"
			echo "检测到洞穴$sum1异常开始重启"
			dox
		else
		echo "洞穴 $sum1正常运行"
		fi
		done
	sleep 10
}
while :
do
if [[ $game_selfstart == "true" ]];then
	shijie
	sleep 10
else
	echo ""
fi
if [[ $modupdates == "true" ]];then
	modupdate
	sleep 10
else
	echo ""
fi
if [[ $gameupdates == "true" ]];then
	jiance
	sleep 10
else
	echo ""
fi
done
	EOF
fi
while :
do
echo -e "\033[34m 提示：[1]启动 [2]关闭 [3]设置 [0.返回菜单 \033[0m"
echo 
	read main2
		case $main2 in
			1)qidong
			break;;
			2)close
			break;;
			3)whsz
			break;;
			0)Main
			break;;	
		esac
done
}
function SetWhite()
{	
	echo "[1]加入白名单 [2]放出白名单 "
	read white1
	case $white1 in
	1)
	cd $HOME
	echo -e "\033[33m "============================================"\033[0m"
	echo -e "\033[33m "[提示]请选择存档目录 [1-5]"\033[0m"
	read filenumber
	echo -e "\033[33m ============================================\033[0m"
	echo -e "\033[33m 请输入要加入白名单的Klei ID\033[0m"
	read ID2
	if [ -d ./.klei/DoNotStarveTogether/Cluster_$filenumber ]
	then
		cd ./.klei/DoNotStarveTogether/Cluster_$filenumber
		if [[ ! `grep "$ID2" whitelist.txt` ]]
		then 
			echo "$ID2" >> whitelist.txt
			echo "已为这个大佬预留一个位置"
		else
			echo "这个大佬已经有一个位置"
		fi
	else
		echo "没有该存档"
	fi
	;;
	2)
	cd $HOME
	echo -e "\033[33m "============================================"\033[0m"
	echo -e "\033[33m "[提示]请选择存档目录 [1-5]"\033[0m"
	read filenumber
	echo -e "\033[33m ============================================\033[0m"
	echo -e "\033[33m 请输入要解除白名单的Klei ID\033[0m"
	read ID2
	if [ -d ./.klei/DoNotStarveTogether/Cluster_$filenumber ]
	then
		cd ./.klei/DoNotStarveTogether/Cluster_$filenumber
		if [[ `grep "$ID2" whitelist.txt` ]]
		then 
			sed -i "/$ID2/d" whitelist.txt
			cd $HOME
			echo "预留位置已开放"
		else
			echo "没有这个基佬的预留位置"
		fi
	else
		echo "没有该存档"
	fi
	;;
	esac
	sleep 2
	Main
}
function SetBlack()
{
	cd $HOME
echo "============================================"
	echo "[1]加入黑名单 [2]放出黑名单 "
	read black1
	case $black1 in
	1)
	echo -e "\033[33m "============================================"\033[0m"
	echo -e "\033[33m "[提示]请选择存档目录 [1-5]"\033[0m"
	read filenumber
	echo -e "\033[33m ============================================\033[0m"
	echo -e "\033[33m 请输入要加入黑名单的Klei ID\033[0m"
	read ID2
	if [ -d ./.klei/DoNotStarveTogether/Cluster_$filenumber ]
	then
		cd ./.klei/DoNotStarveTogether/Cluster_$filenumber
		if [[ ! `grep "$ID2" blacklist.txt` ]]
		then 
			echo "$ID2" >> blacklist.txt
			echo "恶劣的家伙已被关入地上小黑屋"
		else
			echo "恶劣的家伙已经在小黑屋"
		fi
	else
		echo "没有该存档"
	fi
	;;
	2)
	cd $HOME
	echo -e "\033[33m "============================================"\033[0m"
	echo -e "\033[33m "[提示]请选择存档目录 [1-5]"\033[0m"
	read filenumber
	echo -e "\033[33m ============================================\033[0m"
	echo -e "\033[33m 请输入要解除黑名单的Klei ID\033[0m"
	read ID2
	if [ -d ./.klei/DoNotStarveTogether/Cluster_$filenumber ]
	then
		cd ./.klei/DoNotStarveTogether/Cluster_$filenumber
		if [[ `grep "$ID2" blacklist.txt` ]]
		then 
			sed -i "/$ID2/d" blacklist.txt
			cd $HOME
			echo "已放出地上小黑屋"
		else
			echo "这个基佬不在小黑屋"
		fi
	else
		echo "没有该存档"
	fi
	;;
	esac
	Main	
}
function SetAdmin()
{	
	echo "[1]提升管理员 [2]解除管理员 "
	read admin1
	case $admin1 in
	1)
	cd $HOME
	echo -e "\033[33m "============================================"\033[0m"
	echo -e "\033[33m "[提示]请选择存档目录 [1-5]"\033[0m"
	read filenumber
	echo -e "\033[33m ============================================\033[0m"
	echo -e "\033[33m 请输入要提升为管理员的Klei ID\033[0m"
	read ID2
	if [ -d ./.klei/DoNotStarveTogether/Cluster_$filenumber ]
	then
		cd ./.klei/DoNotStarveTogether/Cluster_$filenumber
		if [[ ! `grep "$ID2" adminlist.txt` ]]
		then 
			echo "$ID2" >> adminlist.txt
			echo "管理员已设置"
		else
			echo "已是管理员无需再次添加"
		fi
	else
		echo "没有该存档"
	fi
	;;
	2)
	cd $HOME
	echo -e "\033[33m "============================================"\033[0m"
	echo -e "\033[33m "[提示]请选择存档目录 [1-5]"\033[0m"
	read filenumber
	echo -e "\033[33m ============================================\033[0m"
	echo -e "\033[33m 请输入要提升为管理员的Klei ID\033[0m"
	read ID2
	if [ -d ./.klei/DoNotStarveTogether/Cluster_$filenumber ]
	then
		cd ./.klei/DoNotStarveTogether/Cluster_$filenumber
		if cat "adminlist.txt" | grep "$ID2"
		then 
			sed -i "/$ID2/d" adminlist.txt
			echo "管理员已取消"
		else
			echo "该玩家不是管理员"
		fi
	else
		echo "没有该存档"
	fi
	;;
	esac
	Main
}
function group()
{	
	cd $HOME
	echo -e "\033[34m[提示] 请输入群组id\033[0m"
	read IDS
	clusterPath=".klei/DoNotStarveTogether/Cluster_$groupc/cluster.ini"
		if cat "$clusterPath" | grep "STEAM"
			then
			cd ".klei/DoNotStarveTogether/Cluster_$groupc"
			sed -i '/STEAM/d' cluster.ini
			echo "[STEAM]" >> cluster.ini
		else
			cd ".klei/DoNotStarveTogether/Cluster_$groupc"
			echo "[STEAM]" >> cluster.ini
		fi
	cd $HOME
		if cat "$clusterPath" | grep "steam_group_id"
			then
			cd ".klei/DoNotStarveTogether/Cluster_$groupc"
			sed -i '/steam_group_id/d' cluster.ini
			echo "steam_group_id" = $IDS >> cluster.ini
		else
			cd ".klei/DoNotStarveTogether/Cluster_$groupc"
			echo "steam_group_id" = $IDS >> cluster.ini	
		fi
}
function group_management()
{
cd $HOME
echo -e "\033[34m[提示] 添加群组id后才能设置\033[0m"
echo -e "\033[34m[提示] [1群组管理员是房间管理] [2.群组管理员不是房间管理] [0.返回菜单\033[0m"
clusterPath=".klei/DoNotStarveTogether/Cluster_$groupc/cluster.ini"
while :
do
echo 
	read management
		case $management in
			1)		
				if cat "$clusterPath" | grep "steam_group_admins"
					then
					cd ".klei/DoNotStarveTogether/Cluster_$groupc"
					sed -i '/steam_group_admins/d' cluster.ini
					echo "steam_group_admins = true " >> cluster.ini
				else
					cd ".klei/DoNotStarveTogether/Cluster_$groupc"
					echo "steam_group_admins = true " >> cluster.ini
				fi
				break;;
			2)
				if cat "$clusterPath" | grep "steam_group_admins"
					then
					cd ".klei/DoNotStarveTogether/Cluster_$groupc"
					sed -i '/steam_group_admins/d' cluster.ini
					echo "steam_group_admins = false" >> cluster.ini
				else
					cd ".klei/DoNotStarveTogether/Cluster_$groupc"
					echo "steam_group_admins = false" >> cluster.ini
				fi
				break;;
			0)
				Main
				break;;	
		esac
done
}
function Management_settings()
{
cd $HOME
echo -e "\033[34m[提示] 添加群组id后才能设置\033[0m"
echo -e "\033[34m[提示] [1.仅限群组玩家] [2.不仅限群组玩家] [0.返回菜单]\033[0m"
clusterPath=".klei/DoNotStarveTogether/Cluster_$groupc/cluster.ini"
while :
do
echo 
	read Management_settingss
		case $Management_settingss in
			1)		
				if cat "$clusterPath" | grep "steam_group_only"
					then
					cd ".klei/DoNotStarveTogether/Cluster_$groupc"
					sed -i '/steam_group_only/d' cluster.ini
					echo "steam_group_only = true" >> cluster.ini
				else
					cd ".klei/DoNotStarveTogether/Cluster_$groupc"
					echo "steam_group_only = true" >> cluster.ini
				fi
				break;;
			2)
				if cat "$clusterPath" | grep "steam_group_only"
					then
					cd ".klei/DoNotStarveTogether/Cluster_$groupc"
					sed -i '/steam_group_only/d' cluster.ini
					echo "steam_group_only = false" >> cluster.ini
				else
					cd ".klei/DoNotStarveTogether/Cluster_$groupc"
					echo "steam_group_only = false" >> cluster.ini
				fi
				break;;
			0)
				break;;	
		esac
done
}
function cundang()
{
while :
do
echo -e "\033[34m 提示：[1.加入群组id] [2.群组管理员设置] [3.仅限群组玩家设置] [0.返回菜单 \033[0m"
echo 
	read main3
		case $main3 in
			1)group
			break;;
			2)group_management
			break;;
			3)Management_settings
			break;;
			0)Main
			break;;	
		esac
done
}
function Administrative_group()
{
echo -e "\033[34m[提示] 存档位 [1-5]\033[0m"
read groupc
cundang
}
function encodes()
{
while :
do
echo "请选择存档"
read encodes
echo "如需要玩家存档对应文件夹为玩家KleiID,以下请选否"
echo "编码玩家存档路径：1. 是   2. 否？ 3.返回菜单"
echo
	read main7
		case $main7 in
			1)
			cd $HOME
			if cat ".klei/DoNotStarveTogether/Cluster_1/Master/server.ini" | grep  "encode_user_path"
					then
					cd ".klei/DoNotStarveTogether/Cluster_1/Master"
					sed -i '/encode_user_path/d' server.ini
					echo "encode_user_path = true" >> server.ini
				else
					echo "没有此存档"
			fi
			cd $HOME
			if cat ".klei/DoNotStarveTogether/Cluster_1/Caves/server.ini" | grep  "encode_user_path"
					then
					cd ".klei/DoNotStarveTogether/Cluster_1/Caves"
					sed -i '/encode_user_path/d' server.ini
					echo "encode_user_path = true" >> server.ini
				else
					echo "没有此存档"
			fi			
			break;;
			2)
			cd $HOME
			if cat ".klei/DoNotStarveTogether/Cluster_1/Master/server.ini" | grep "encode_user_path"
					then
					cd ".klei/DoNotStarveTogether/Cluster_1/Master"
					sed -i '/encode_user_path/d' server.ini
					echo "encode_user_path = false" >> server.ini
				else
					echo "没有此存档"
			fi
			cd $HOME
			if cat ".klei/DoNotStarveTogether/Cluster_1/Caves/server.ini" | grep "encode_user_path"
					then
					cd ".klei/DoNotStarveTogether/Cluster_1/Caves"
					sed -i '/encode_user_path/d' server.ini
					echo "encode_user_path = false" >> server.ini
				else
					echo "没有此存档"
			fi	
			break;;
			3)Main
			break;;
		esac
done
}
function Listmanage()
{
while :
do
	echo -e "\033[33m "============================================"\033[0m"
	echo -e "\033[33m "[1]设置管理员 [2]管理黑名单 [3]管理白名单 [4]管理群组 [5]编码玩家存档路径 [0]返回菜单"\033[0m"
	read list1
	case $list1 in
		1)SetAdmin
		break;;
		2)SetBlack
		break;;
		3)SetWhite
		break;;
		4)Administrative_group
		break;;
		5)encodes
		break;;
		0)Main
		break;;
	esac
done
}
function congzhidm()
{
	echo -e "\033[34m[提示] 存档位 [1-5]\033[0m"
	read input_save
	cd $HOME  
	rm -r ./.klei/DoNotStarveTogether/Cluster_"$input_save"/Master/save
	Main
}
function congzhidx()
{
	echo -e "\033[34m[提示] 存档位 [1-5]\033[0m"
	read input_save
	cd $HOME  
	rm -r ./.klei/DoNotStarveTogether/Cluster_"$input_save"/Caves/save
	Main
}
function congzhisj()
{
	echo -e "\033[34m[提示] 存档位 [1-5]\033[0m"
	read input_save
	cd $HOME  
	rm -r ./.klei/DoNotStarveTogether/Cluster_"$input_save"/Master/save
	rm -r ./.klei/DoNotStarveTogether/Cluster_"$input_save"/Caves/save
	Main
}
function chongzhi()
{  
	echo -e "\033[34m[提示] 重置 [1.地面] [2.洞穴] [3.地面+洞穴] [0.返回菜单]\033[0m"
	read input_mode 
	cd $HOME
	case $input_mode in  
		1)
			congzhidm;;
		2)
			congzhidx;;
		3)  
			congzhisj;;
		0)  Main;;
			
		*)
			echo -e "\033[31m[注意] Illegal Command,Please Check\033[0m" ;;
	esac
	echo "$dividing"
	Main
}
function beifeng()
{
	cd $HOME
	if [ -d .klei ]
	then
	cd .klei
	zip -r Dst$time2.zip DoNotStarveTogether
	echo -e "\033[33m[提示] 存档 DoNotStarveTogether$time2 已备份\033[0m"
	fi
	Main
}
function huifu()
{
	cd $HOME
	if [ -d .klei ]
	then 
	cd .klei
	txt3=$(ls | grep 'zip')
	arraya=($txt3)
	for((l=0;l<${#arraya[@]};l++))
		do
		echo "[ $l ]"${arraya[$l]}
	done
		echo "请根据时间选择要恢复的备份"
		read bf
	if [ -d DoNotStarveTogether ]
	then
		rm -r DoNotStarveTogether
	else
		echo "存档已经删除直接恢复"
	fi
	unzip ${arraya[$bf]}
	echo -e "\033[33m[提示] 存档 已恢复\033[0m"
	fi
	Main
}
function wup()
{
#echo "请输入要给予玩家的物品"
#read WPS
while :
do
echo -e "\033[34m"[提示]请选择要给予玩家的物品" \033[0m"
echo -e "\033[34m"提示:[1.木头] [2.蜘蛛] [3.彩虹宝石]" \033[0m"
echo 
	read main1
		case $main1 in
			1)WPS=log
			break;;
			2)WPS=spider
			break;;
			3)WPS=opalpreciousgem
			break;;
		esac
done
}
function shen()
{
echo -e "\033[34m"[提示] 请输入世界数量" \033[0m"
read numsh
	screen -S "地面 1" -X stuff "for i, v in ipairs(TheNet:GetClientTable()) do print(string.format(\"playerlist %s [%d] %s %s %s\", 1646565813466, i-1, v.userid, v.name, v.prefab )) end \n"
	echo "[提示]请输入玩家id"
	read IDS
	wup
	echo "[提示]请输入数量"
	read numa
	for((nums=0;nums<$numsh;nums++))
		do
		nums1=$nums
	for((z=0;z<$numa;z++))
		do
	screen -S "地面 $nums1" -X stuff "
	for k, v in pairs(AllPlayers) do if v and v.userid == '$IDS'  then local item = SpawnPrefab(\"$WPS\") if item then item.Transform:SetPosition(v.Transform:GetWorldPosition()) end end end
	 \n"
	screen -S "洞穴 $nums1" -X stuff "
	for k, v in pairs(AllPlayers) do if v and v.userid == '$IDS'  then local item = SpawnPrefab(\"$WPS\") if item then item.Transform:SetPosition(v.Transform:GetWorldPosition()) end end end
	 \n"
	echo -e "\034[34m[提示] 已成功给予$IDS $numa个 $WPS \033[0m"
	done
done
shen
}
function jiushu()
{
cd $HOME
cd ".klei/DoNotStarveTogether/Cluster_1/Master/save/session"
for r in $(ls); do
	cd $r
	break
done
comparison="0"
	for qw in $(ls -d */); do
		comparison=($qw)
		echo "$comparison"
	done
	echo "[提示] 只有和主世界在同一服务器的的情况才能使用"
echo -e "\033[33m 请输入玩家克雷ID \033[0m"
read IDS3
echo -e "\033[33m [提示] 请选择存档 \033[0m"
read cundang2
echo -e "\033[33m 提示 [1.地面 ] [2.洞穴 ] \033[0m"
read shijiea3
	case $shijiea3 in  
		1)
			shijied=Master;;
		2)
			shijied=Caves;;
	esac
cd $HOME
cd ".klei/DoNotStarveTogether/Cluster_$cundang2/$shijied/save/session"
for za in $(ls); do
	cd $za
	break
done
cd $HOME
cp -a /root/.klei/DoNotStarveTogether/Cluster_1/Master/save/session/$r/$IDS3/* /root/.klei/DoNotStarveTogether/Cluster_$cundang2/$shijied/save/session/$za/$IDS3
echo "已成功"
Main
}
function Gameupdate()
{
	echo -e "\033[34m[提示] 服务器正在关闭请稍等 \033[0m"
	screen -S "地面 1" -X stuff "c_announce("\"所有世界服务器因改动或更新需要重启，预计耗时三分钟，给你带来的不便还请谅解！\"")\n"
	screen -S "地面 1" -X stuff "c_save() \n"
	sleep 5
	killall screen
		cd ./steamcmd
	./steamcmd.sh +login anonymous +app_update 343050 validate +quit
	cd "$HOME"
	clear
	echo "更新完毕"
	Main
}
function Library()
{
	sudo add-apt-repository multiverse
	sudo dpkg --add-architecture i386
	sudo apt-get -y update
	sudo apt-get -y install screen
	sudo apt-get -y install lib32gcc1
	sudo apt-get -y install lib32stdc++6
	sudo apt-get -y install libcurl4-gnutls-dev:i386
	sudo apt-get -y install htop
	sudo apt-get -y install -y zip
}
function Prepare()
{
if [ ! -d "./steamcmd" ]
then
Library
mkdir ./steamcmd
cd ./steamcmd
wget https://wuter.cn/wp-content/uploads/DST_tools/steamcmd_linux.tar.gz
tar -xvzf steamcmd_linux.tar.gz
rm -f steamcmd_linux.tar.gz
./steamcmd.sh +login anonymous +app_update 343050 validate +quit
fi
for((f=1;f<6;f++));do
cd "$HOME"
	if [ ! -d "./.klei/DoNotStarveTogether/Cluster_$f" ]
	then 
		mkdir -p ./.klei/DoNotStarveTogether/Cluster_$f
	fi
	if [ ! -f "./.klei/DoNotStarveTogether/Cluster_$f/cluster_token.txt" ]
	then 
		echo "pds-g^KU_vCuBS8G6^yC3bjv8NbHUmjZeMcraxqpYyT0FykmOP·cZIEmEZSGwQ=" >> ./.klei/DoNotStarveTogether/Cluster_$f/cluster_token.txt
	fi
	if [ ! -d "./.klei/DoNotStarveTogether/Cluster_$f/Master" ]
	then 
		mkdir -p ./.klei/DoNotStarveTogether/Cluster_$f/Master/
	fi
	if [ ! -d "./.klei/DoNotStarveTogether/Cluster_$f/Caves" ]
	then 
		mkdir -p ./.klei/DoNotStarveTogether/Cluster_$f/Caves
	fi
done
}
function Main()
{
clear
echo -e "\033[33m ============================================\033[0m"
echo -e "\033[33m ===欢迎使用黎明一键端饥荒专用服务器架设器=== \033[0m"
echo -e "\033[33m ============================================\033[0m"
while :
do
time2=$(date "+%Y%m%d%H%M%S")
time3=$(date "+%Y-%m-%d %H:%M:%S")
echo -e "\033[34m [1.启动] [2.更新] [3.查看] [4.关闭] [5.维护]\033[0m"
echo -e "\033[34m [6.名单] [7.重置] [8.备份] [9.恢复] [10.神 ]\033[0m"
echo -e "\033[34m [11.救赎]   \033[0m"
echo 
	read main1
		case $main1 in
			1)Startserver
			break;;
			2)Gameupdate
			break;;
			3)CloseServer
			break;;
			4)killprocess
			break;;
			5)Startrestet
			break;;
			6)Listmanage
			break;;	
			7)chongzhi
			break;;	
			8)beifeng
			break;;
			9)huifu
			break;;
			10)shen
			break;;
			11)jiushu
			break;;
		esac
done
}

echo -e "\033[33m  欢迎使用 \033[0m"
Prepare
echo -e "\033[33m 准备完毕\033[0m"
echo "============================================"
Main
