extends Node

var votes = 1553  # 投票数
var ever_votes = 0
var rank = 61  # 順位
var hidan = 0 # 被弾数
var bomb = 0 # ボム数
var bomb_dec = 50
var hidan_dec = 100
var is_game_started = false
var power = 2

signal finish_signal()
signal reset_signal()

# 順位基準リスト（降順）
var vote_thresholds = [
	["博麗 霊夢", 21959],
	["霧雨 魔理沙", 20249],
	["フランドール・スカーレット", 17324],
	["古明地 こいし", 16273],
	["魂魄 妖夢", 14445],
	["十六夜 咲夜", 14437],
	["レミリア・スカーレット", 13785],
	["古明地 さとり", 9921],
	["藤原 妹紅", 9377],
	["チルノ", 8159],
	["西行寺 幽々子", 7973],
	["アリス・マーガトロイド", 7417],
	["射命丸 文", 7235],
	["東風谷 早苗", 6762],
	["鈴仙・優曇華院・イナバ", 6491],
	["八雲 紫", 5996],
	["パチュリー・ノーレッジ", 5559],
	["紅 美鈴", 5302],
	["秦 こころ", 5235],
	["比那名居 天子", 5207],
	["ルーミア", 5152],
	["洩矢 諏訪子", 4914],
	["多々良 小傘", 4806],
	["風見 幽香", 4288],
	["四季映姫・ヤマザナドゥ", 4151],
	["純狐", 3716],
	["伊吹 萃香", 3715],
	["犬走 椛", 3695],
	["八雲 藍", 3635],
	["蓬莱山 輝夜", 3519],
	["霊烏路 空", 3463],
	["依神紫苑", 3372],
	["豊聡耳 神子", 3305],
	["宇佐見 蓮子", 3220],
	["鬼人 正邪", 3174],
	["水橋 パルスィ", 3144],
	["八意 永琳", 3100],
	["ヘカーティア・ラピスラズリ", 3012],
	["稗田 阿求", 3011],
	["物部 布都", 2967],
	["河城 にとり", 2849],
	["饕餮 尤魔", 2803],
	["鍵山 雛", 2774],
	["稀神 サグメ", 2731],
	["摩多羅隠岐奈", 2540],
	["茨木 華扇", 2528],
	["火焔猫 燐", 2278],
	["マエリベリー・ハーン", 2220],
	["聖 白蓮", 2087],
	["上白沢 慧音", 1926],
	["橙", 1924],
	["ミスティア・ローレライ", 1898],
	["封獣 ぬえ", 1883],
	["ナズーリン", 1776],
	["飯綱丸 龍", 1680],
	["魅魔", 1667],
	["小悪魔", 1611],
	["ドレミー・スイート", 1602],
	["天弓 千亦", 1590],
	["クラウンピース", 1568],
	["菅牧 典", 1553]
]

func reset():
	emit_signal("reset_signal")
	votes = 1553
	ever_votes = 0
	rank = 61
	hidan = 0
	bomb = 0
	power = 2
	is_game_started = false

# 票数に基づいて順位を返す関数
func get_rank(current_votes: int) -> int:
	for i in range(GameData.vote_thresholds.size()):
		if current_votes >= GameData.vote_thresholds[i][1]:
			return i + 1
	return GameData.vote_thresholds.size() + 1  # リスト内にない場合

func get_character_by_rank(current_rank: int) -> String:
	return GameData.vote_thresholds[current_rank - 1][0]

func get_bomb_dec() -> int:
	return (hidan + bomb + 1) * 20

func get_hidan_dec() -> int:
	return (hidan + bomb + 1) * 100

func emit_finish_signal():
	emit_signal("finish_signal")
	is_game_started = false

func get_spawn_position() -> Vector2:
	var rng = RandomNumberGenerator.new()
	return Vector2( 1260 + rng.randf_range(-5, 5), rng.randf_range(120, 600))

func get_random_true(p) -> bool:
	var rng = RandomNumberGenerator.new()
	return rng.randf() < p
