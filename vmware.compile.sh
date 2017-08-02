#!/bin/bash
    echo " Script para compilação de módulos do VMware Player/Workstation"
    
    # Autor: Jeferson Lopes
    # Analista de Tecnologia da Informação
    
    echo -e "\n \n Antes de executar este script, certifique-se de já o ter instalado o VMware Player "
    echo -e " ou VMware Workstation a partir dos binários de instalação versão 12.5.7: \n"
    echo " - VMware-Player-12.5.7-5813279.x86_64.bundle"
    echo -e " - VMware-Workstation-Full-12.5.7-5813279.x86_64.bundle \n"
    echo -e "\n Obtenha em: \n - https://www.vmware.com/products/player/playerpro-evaluation.html \n"
    echo -e " ou \n - https://my.vmware.com/en/web/vmware/info/slug/desktop_end_user_computing/vmware_workstation_pro/12_0\n \n"
    
    echo -e " Verifique também se os pacotes de desenvolvimento para o kernel estão instalados e atualizados com: \n"
    echo -e " # dnf install kernel-headers kernel-devel gcc glibc-headers patch \n"
    echo -e " # dnf /usr/bin/update\n"
    echo -e "\n \n Você pode elevar seu privilégio com 'sudo /usr/bin/su' se teu usuário possuir esta permissão \n \n"
    echo -e " Pressione a tecla 'Enter' para continuar ou 'CTRL + C' para cancelar \n"
    read 

# VMWARE_USE_SHIPPED_LIBS=force vmware
    
    # Variáveis
    LIB64='/usr/lib64'
    KERNELMODULES="/lib/modules/`uname -r`"
    KERNELMISC="$KERNELMODULES/misc"
    LIBGIO='libgio-2.0.so.0/libgio-2.0.so.0'
    LIBGLIB='libglib-2.0.so.0/libglib-2.0.so.0'
    LIBGMODULE='libgmodule-2.0.so.0/libgmodule-2.0.so.0'
    LIBGOBJECT='libgobject-2.0.so.0/libgobject-2.0.so.0'
    LIBGTHREAD='libgthread-2.0.so.0/libgthread-2.0.so.0'
    SOURCES='/usr/lib/vmware/modules/source'
    VLIBGIO='libgio-2.0.so.0.????.?'
    VLIBGLIB='libglib-2.0.so.0.????.?'
    VLIBGMOD='libgmodule-2.0.so.0.????.?'
    VLIBGOBJ='libgobject-2.0.so.0.????.?'
    VLIBGTHR='libgthread-2.0.so.0.????.?'
    VMWARE='/usr/lib/vmware'
    

if [ ! -d $VMWARE ]; then 
    echo -e "\nInstale o VMware a partir do arquivo .bundle \n"
elif [ -d $VMWARE ]; then
    cd $VMWARE/lib
    #alias cp='cp -afvr'
    
    # Cópia de Bibliotecas
    cp -afvr $LIB64/$VLIBGIO $LIBGIO
    cp -afvr $LIB64/$VLIBGLIB $LIBGLIB
    cp -afvr $LIB64/$VLIBGMOD $LIBGMODULE
    cp -afvr $LIB64/$VLIBGOBJ $LIBGOBJECT
    cp -afvr $LIB64/$VLIBGTHR $LIBGTHREAD
    echo -e "\nBibliotecas copiadas com sucesso... \n"
       
else
    echo -e "\nBibliotecas não copiadas. Verifique a instalação do seu produto VMware \n"
    exit 0
fi
     
if [ -d $SOURCES/vmmon-only ]; then
    echo -e "\nSources VMMon encontradas. Excluindo arquivos antigos \n"
    cd $SOURCES
    rm  -rf vmmon-only
    echo -e "\nDescompactando arquivos para fontes \n"
    tar -xf vmmon.tar
    echo -e "\nAcessando fontes..."
    cd /$SOURCES/vmmon-only
    echo -e "\nIniciando compilação de módulo vmmon.ko \n"
    make
    echo -e "\nMódulo VMMon compilado \n"
elif [ ! -d $SOURCES/vmmon-only ]; then
    echo -e "\nSources VMMon não encontrados. Descompactando arquivos para fontes \n"
    cd $SOURCES
    tar -xf vmmon.tar
    echo -e "\nAcessando fontes... \n"
    cd $SOURCES/vmmon-only
    echo -e "\nIniciando compilação de módulo vmmon.ko \n" 
    make
    echo -e "\nMódulo VMMon compilado \n"
else 
    echo -e "\nNão foi possível a verificação e descompactação dos sources para vmmon. \n"
    exit 0
fi
        
if [ -d $SOURCES/vmnet-only ]; then
    echo -e "\nSources VMNet encontradas. Excluindo arquivos antigos \n"
    cd $SOURCES
    rm  -rf vmnet-only
    echo -e "\nDescompactando arquivos para fontes \n"
    tar -xf vmnet.tar
    echo -e "\nAcessando fontes... \n"
    cd $SOURCES/vmnet-only
    echo -e "\nIniciando compilação de módulo vmmon.ko \n"
    make
    echo -e "\nMódulo VMNet compilado \n"
elif [ ! -d $SOURCES/vmnet-only ]; then
    echo -e "\nSources VMNet não encontrados. Descompactando arquivos para fontes \n"
    cd $SOURCES
    tar -xf vmnet.tar
    echo -e"\nAcessando fontes... \n"
    cd $SOURCES/vmnet-only
    echo -e "\nIniciando compilação de módulo vmmon.ko \n"
    make
    echo -e "\nMódulo VMNet compilado \n"
else 
    echo -e "\nNão foi possível a verificação e descompactação dos sources para vmmon. \n"
    exit 0
fi

if [ ! -d $KERNELMODULES ]; then
    echo -e "\nCriando diretórios para $KERNELMODULES \n"
    mkdir $KERNELMODULES 
elif
    [ -d $KERNELMODULES ]; then
    echo -e "\nDiretório $KERNELMODULES encontrado. \n" || echo -e "\nDiretório $KERNELMODULES não encontrado. \n"
else
    echo -e "\nDiretórios para $KERNELMODULES encontrados. Continuando... \n"
fi

if [ ! -d $KERNELMISC ]; then
    echo -e "\nCriando diretórios para $KERNELMISC \n"
    mkdir $KERNELMISC
elif
    [ -d $KERNELMISC ]; then
    echo -e "\nDiretório $KERNELMISC encontrado. \n" || echo -e "\nDiretório $KERNELMISC não encontrado. \n"
else 
    echo -e "\nNão foi possível criar diretórios $KERNELMODULES e $KERNELMISC \n"
    exit 0
fi

if [ -d $KERNELMISC ]; then
    cd $SOURCES/vmmon-only
    cp -avfr $SOURCES/vmmon-only/vmmon.ko $KERNELMISC
    cd $SOURCES/vmnet-only
    cp -avfr $SOURCES/vmnet-only/vmnet.ko $KERNELMISC
    echo -e "\nMódulos copiados \n"
else
    echo -e "\nNão é possível criar ou acessar $KERNELMODULES, verifique o caminho e tente criar manualmente \n"
fi

if [ -e $KERNELMISC/vmmon.ko ]; then
    if [ -e $KERNELMISC/vmnet.ko ]; then
        depmod -a
        modprobe vmmon
        modprobe vmnet
        echo -e "\n \nMódulos carregados \nVMWARE está pronto para ser executado, utilize o comando abaixo: \n"
        echo -e "VMWARE_USE_SHIPPED_LIBS=force /usr/lib/vmware/bin/vmware \n \nCaso ocorra algum problema, reinicie os serviços pertinentes. \n"
    else
        echo -e "\nMódulos não carregados. \n"
    fi
else
    echo -e "\nVerifique se vmmon.ko e vmnet.ko estão corretamente em $KERNELMISC e subá-os manualmente se possível \n"
    exit 0
fi

# VMWARE_USE_SHIPPED_LIBS=force /usr/lib/vmware/bin/vmware

#vmware-modconfig --console --install-all
