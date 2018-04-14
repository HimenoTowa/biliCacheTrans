 require "find"
require "fileutils"


def biliCacheTrans(topPath, from_user)
  unless File.directory?("my_video")
    Dir.mkdir("my_video")
  end
  Find.find(topPath) do |path|
    if File.basename(path) =~ /^0(\..+)$/ && File.extname(path) != ".sum" #文件为0.*** #小括号里的，用$1获取，那是文件后缀！
      new_name = File.dirname(path).split("/")[1]  #./123456/1/lua.mp4.bapi.9  123456即为b站av号
      if $1 == ".blv"  #不是视频格式，改成.mp4
        if from_user == "copy"
          FileUtils.cp(path,"my_video/"+new_name+".mp4")  #FileUtils.cp，复制加改名
        else
          FileUtils.mv(path,"my_video/"+new_name+".mp4")
        end
      else
        if from_user == "copy"
          FileUtils.cp(path,"my_video/"+new_name+$1)
        else
          FileUtils.mv(path,"my_video/"+new_name+$1)
        end
      end
    end
  end
  puts "全部完成!"
end

puts """将生成一个my_video文件夹，并【复制/剪切】bilibili的缓存视频，存放到该文件夹中,视频文件名将改为av号.
！请确定本程序位置在bilibili缓存视频相同的文件夹内！
(和一堆名称为数字的文件夹并列放在一起)
复制：输入copy 剪切：输入cut
再回车，开始执行程序
不执行请关闭                                  2018.4.14 by land
"""
fromUser = $stdin.gets.chomp
biliCacheTrans(".", fromUser) if fromUser == "copy" || fromUser == "cut"
$stdin.gets.chomp

#用ocra打包成.exe文件 ocra biliCacheTrans.rb --no-dep-run --icon c:/..... --add-all-cores --gem-full --output bct.exe
#open in Atom 测试看能添加不
