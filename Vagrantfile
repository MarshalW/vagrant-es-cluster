# frozen_string_literal: true

PROXY_URL = 'http://192.168.0.133:1087/'
NETWORK_INTERFACE='en7: USB 10/100/1000 LAN'


Vagrant.configure('2') do |config|
  # 安装代理服务器，如没有可以屏蔽掉
  # 如需使用，需要提前安装vagrant-proxyconf
  if Vagrant.has_plugin?('vagrant-proxyconf')
    config.proxy.http = PROXY_URL
    config.proxy.https = PROXY_URL
    config.proxy.no_proxy = 'localhost,127.0.0.1,.example.com,.aliyun.com,.0,.1,.2,.3,.4,.5,.6,.7,.8,.9,.10,.11,.12,.13,.14,.15,.16,.17,.18,.19,.20,.21,.22,.23,.24,.25,.26,.27,.28,.29,.30,.31,.32,.33,.34,.35,.36,.37,.38,.39,.40,.41,.42,.43,.44,.45,.46,.47,.48,.49,.50,.51,.52,.53,.54,.55,.56,.57,.58,.59,.60,.61,.62,.63,.64,.65,.66,.67,.68,.69,.70,.71,.72,.73,.74,.75,.76,.77,.78,.79,.80,.81,.82,.83,.84,.85,.86,.87,.88,.89,.90,.91,.92,.93,.94,.95,.96,.97,.98,.99,.100,.101,.102,.103,.104,.105,.106,.107,.108,.109,.110,.111,.112,.113,.114,.115,.116,.117,.118,.119,.120,.121,.122,.123,.124,.125,.126,.127,.128,.129,.130,.131,.132,.133,.134,.135,.136,.137,.138,.139,.140,.141,.142,.143,.144,.145,.146,.147,.148,.149,.150,.151,.152,.153,.154,.155,.156,.157,.158,.159,.160,.161,.162,.163,.164,.165,.166,.167,.168,.169,.170,.171,.172,.173,.174,.175,.176,.177,.178,.179,.180,.181,.182,.183,.184,.185,.186,.187,.188,.189,.190,.191,.192,.193,.194,.195,.196,.197,.198,.199,.200,.201,.202,.203,.204,.205,.206,.207,.208,.209,.210,.211,.212,.213,.214,.215,.216,.217,.218,.219,.220,.221,.222,.223,.224,.225,.226,.227,.228,.229,.230,.231,.232,.233,.234,.235,.236,.237,.238,.239,.240,.241,.242,.243,.244,.245,.246,.247,.248,.249,.250,.251,.252,.253,.254,.255'
  end

  config.vm.provision :shell, privileged: true, path: './scripts/init_common.sh'

  config.vm.define :admin do |admin|
    admin.vm.provider :virtualbox do |vb|
      vb.name = 'admin'
      vb.memory = 2048
      vb.cpus = 2
    end
    admin.vm.box = 'ubuntu/focal64'
    admin.vm.hostname = 'admin'
    admin.vm.network :public_network, ip: '192.168.0.70', bridge: NETWORK_INTERFACE
    admin.vm.provision :shell, privileged: true, path: './scripts/init_admin.sh'
    admin.vm.provision :shell, privileged: false, path: './scripts/set_admin.sh'
  end

  #   %w[master1 master2 master3 data1 data2].each_with_index do |name, i|
  %w[master1].each_with_index do |name, i|
    config.vm.define name do |node|
      node.vm.provider 'virtualbox' do |vb|
        vb.name = name
        vb.memory = 2048
        vb.cpus = 2
      end
      node.vm.box = 'ubuntu/focal64'
      node.vm.hostname = name
      node.vm.network :public_network, ip: "192.168.0.#{i + 71}", bridge: NETWORK_INTERFACE
      node.vm.provision :shell, privileged: true, path: './scripts/init_es.sh'
      node.vm.provision :shell, privileged: false, inline: <<~SHELL
        cat /vagrant/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
      SHELL
    end
  end

  config.vm.provision :shell, privileged: false, path: './scripts/set_users.sh'
end