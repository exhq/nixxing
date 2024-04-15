#!/run/current-system/sw/bin/bash
sudo ls > /dev/null
gum style \
        --border double \
        --foreground 212 --border-foreground 212 --align center --width 50 --margin "1 2" --padding "2 4" \
        'nixxing-confupdate' 'project with questionable name made by a questionable dude'
sleep 1

cp /etc/nixos/configuration.nix ~/confupdate
isok=0
while [ "$isok" -eq 0 ]; do
    vim ~/confupdate
    diff --color /etc/nixos/configuration.nix ~/confupdate
    echo "Is this ok?"
    answer=$(gum choose "yop", "nop", "nop, let me out")
    if [ "$answer" = "nop, let me out" ]; then
        isok=1
        exit
    elif [ "$answer" = "yop," ]; then
        isok=1
    fi
done
sudo cp ~/confupdate /etc/nixos/configuration.nix
rm ~/confupdate
gum spin --spinner dot --show-output --title "Running rebuild -- " -- sudo nixos-rebuild switch
