# Wireshark-GTK-Uebungsumgebung
Dieses Programm dient zum Ueben des Umgangs mit Wireshark auf einer **x86** Umgebung. 
Wireshark(-gtk) wird hierbei ueber Broadwayd im Webbrowser angezeigt. 
Dabei werden abhaengig vom start.sh Skript, welches ueber den HSESpion.service ausgerufen wird, 16 * x Wireshark
Instanzen gestartet.

**Systemanforderungen:**

Falls 16 Instanzen:
- min. 8GB RAM
- 20GB Festplattenspeicher


**1. Schritt: VM einrichten und Guest Additions in VirtualBox installieren**

```
usermod -aG sudo username
sudo apt install linux-headers-$(uname -r)
sudo apt install build-essential
sudo apt install vim
sudo apt install git
sudo apt install devscripts
```
**Anschliessend ueber Devices - *Insert Guest Additions CD Image* das Laufwerk einbinden.
Die Dateien aus dem Laufwerk in einen separaten Ordner kopieren, hier /home/user/Documents/vbox**
```
cd /home/user/Documents
mkdir vbox
cd vbox
```
**Dateien aus dem Laufwerk in diesen Ordner kopieren (alle!)**
```
su
chmod +x VBoxLinuxAdditions.run
sh ./VBoxLinuxAdditions.run
systemctl reboot
```

**2. Schritt: Patches fuer libgtk-3-0 und wireshark-gtk anwenden:**

**2.1 Schritt: Repository herunterladen**

Zunaechst muss das Repository mit den Patches heruntergeladen werden.
```
cd /home/user/Documents
git clone https://github.com/zeya117/Wireshark-GTK-Uebungsumgebung.git
```

**2.2 Schritt: libgtk-3-0**

``` 
mkdir /home/user/Documents/GTK
cd /home/user/Documents/GTK
sudo apt-get source libgtk-3-0
sudo apt-get build-dep libgk-3-0
cd libgtk+3.0-3.24.5
```
Nun muessen die Patches noch angewendet werden.
``` 
patch -p1 < ../Wireshark-GTK-Uebungsumgebung/GTK/ct_raspion_gtk+3.0-3.24.5.patch
```
Anschliessend wird der Uebersetzungs- und Bauvorgang gestartet mit:
``` 
sudo debuild -i -us -uc -b
```

Und eingerichtet im Ordner drueber mit:

```
sudo dpkg -i ../*.deb
``` 

**2.3 Schritt: wireshark-gtk**

``` 
mkdir /home/user/Documents/WIRESHARK
cd /home/user/Documents/
sudo apt-get source wireshark-gtk
sudo apt-get build-dep wireshark-gtk
cd wireshark-2.6.8
```
Nun muessen die Patches noch angewendet werden.
``` 
patch -p1 < ../Wireshark-GTK-Uebungsumgebung/WIRESHARK/ct_raspion_wireshark-gtk-2.6.8.patch
```
Anschliessend wird der Uebersetzungs- und Bauvorgang gestartet mit:
``` 
sudo debuild -i -us -uc -b
```

Und eingerichtet im Ordner drueber mit:

```
sudo dpkg -i ../*.deb
``` 


**3. Schritt: Repository herunterladen und Installationsskript ausfuehren**

```
cd /home/users/Documents/Wireshark-GTK-Uebungsumgebung
./install2.sh
```


Hierbei handelt es sich um eine abgespeckte Variante des Raspions aus der c't 1/2020 mit lediglich Wireshark als Service.

Ein großes Dankeschoen fuer die Unterstuetzung geht hierbei an Herrn Siering von der c't. 


### Articles in c't (German)

In c't 1/2020:

[c’t-Raspion: Datenpetzen finden und bändigen](https://www.heise.de/ct/ausgabe/2020-1-c-t-Raspion-Datenpetzen-finden-und-baendigen-4611153.html)

[c't-Raspion: Projektseite – Foren weitere Hinweise](https://www.heise.de/ct/artikel/c-t-Raspion-Projektseite-4606645.html)

