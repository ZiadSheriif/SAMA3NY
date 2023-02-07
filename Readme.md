# <img  align="center" width= 65px  src="https://media0.giphy.com/media/MeDFeqDC4EMFiKEEMn/giphy.gif?cid=ecf05e4768qyfkj6aq97kbwzznwnfataycnpnnistsed2qbp&rid=giphy.gif&ct=s"> SAMA3NY

<div align="center">

<img height=500px src="https://cdn.dribbble.com/users/945078/screenshots/2863933/no-signal___2x.gif">
<div align="center"  width=10%>

### "Don't Worry, Your Message Will Be Sent 🔊"

</div>
</div>

<hr style="background-color: #4b4c60"></hr>

## <img align= center width=50px height=50px src="https://thumbs.gfycat.com/HeftyDescriptiveChimneyswift-size_restricted.gif"> Table of Contents

- <a href ="#about"> 📙 Overview</a>
- <a href ="#Started"> 💻 Get Started</a>
- <a href ="#work"> ⚒️ Work Explanation</a>
- <a href ="#Contributors"> ✨ Contributors</a>
- <a href ="#License"> 🔒 License</a>
<hr style="background-color: #4b4c60"></hr>
<a id = "about"></a>

## <img align="center"  height =50px src="https://user-images.githubusercontent.com/71986226/154076110-1233d7a8-92c2-4d79-82c1-30e278aa518a.gif"> Overview

<ul>
 <li>
It is required to modulate three speech signals using the following scheme:

<div align="center">
<br>
<img width="500" src="https://user-images.githubusercontent.com/71986226/217121669-1b456300-48b1-4dcc-886f-93a8e3af40f6.png" >
</div>
<br>
and then perform synchronous demodulation.
</li>
<br>
<li>
Then do the following operation:

<ol>
<br>
<li>
	Obtain the modulated signal. Plot it in time domain. Plot its magnitude spectrum
</li>
<li>
Perform synchronous demodulation to restore the three signals.
</li>
<li>
		Perform demodulation three times with phase shifts of 10, 30, 90 degrees for both carriers.
</li>
<li>
		For x_1 (t), perform demodulation two times with a local carrier frequency that is different by 2 Hz and 10 Hz from its carrier frequency.
</li>

</ol>
</li>
<li> <a href="https://github.com/ZiadSheriif/SAMA3NY/blob/main/project.docx">Project Description</a></li>
</ul>
<hr style="background-color: #4b4c60"></hr>
<a id = "Started"></a>

## <img  align= center width=50px height=50px src="https://c.tenor.com/HgX89Yku5V4AAAAi/to-the-moon.gif"> Get Started

<ol>
<li>Clone the repository.

<br>

```sh
git clone https://github.com/ZiadSheriif/SAMA3NY
```

</li>
<li>Put Inputs in folder </li>
<br>

``` sh
cd ./signals
```

</li>
<li>Run File</li>
<br>

``` sh
cd ./project.m
```

</li>
<li>Output will be in folder </li>
<br>

``` sh
cd ./Output_signals
```

</li>
</ol>

<hr style="background-color: #4b4c60"></hr>


<a id ="work"></a>

## <img  align="center" width= 70px src="https://media2.giphy.com/media/KoNYPNsRlbkCWD2ykO/giphy.gif?cid=ecf05e477yrbjph7rxl4lw1ya1upgcck9fju3nipn3iu8s8n&rid=giphy.gif&ct=s"> Work Explanation

### Input signals

> Firstly, we read three signals with different sounds and make them have the same frequency sampling =250000 by make resemble to them and find the length of each one along with max length in-order to be able to sum all modulated signal of each input. We make all audios have the same length by adjusting all of them by adding zero to make have same length. Secondly got time and frequencies intervals. Then we calculated omega (ω1, ω2) by ω=2*pi*const in frequency domain. Then we got carrier in cos and sin domain 
Carrier Signal One=cos (2*pi* ω1) 
Carrier Signal Two=sin (2*pi* ω2)
<br>
<table>
<tr>
<th >
<div  align="center">
<strong>
Signal 1
</strong>
</div>
</th>
<th>
<div  align="center">
<strong>
Signal 2
</strong>
</div>
</th>
<th>
<div  align="center">
<strong>
Signal 3
</strong>
</div>
</th>
</tr>
<tr>
<td>
<img  src="https://user-images.githubusercontent.com/71986226/217222582-ae79fd8f-99bb-4d7b-8010-1b3e024882d4.png">
</td>
<td>
<img src="https://user-images.githubusercontent.com/71986226/217222763-a91bfc2f-a14c-4ede-b24e-e02b5aed4761.png">
</td>
<td>
<img src="https://user-images.githubusercontent.com/71986226/217222805-5bdda761-b810-4e59-9fd1-92dfecfb6abe.png">
</td>

</tr>
</table>

### Modulated signal:

<ol>
<li>
Calculate modulated signal by multiplying signal and carrier
</li>
<li>
Calculate Fourier transform of modulated signal returned from step 1
</li>
<li>
Calculate phase of modulated signal returned from step 1
</li>
<li>
Sum all modulated signals of all audios
</li>
<li>
FFT to summation of modulated signals
</li>
<li>
Calculate phase of modulated signals
</li>
<li>
Calculate frequency band pass which is used in de-modulation
</li>
</ol>

<table>
<tr>
<td>
<img  src="https://user-images.githubusercontent.com/71986226/217224606-3307e139-83a1-406f-b6ae-4da97931b544.png">
</td>
<td>
<img src="https://user-images.githubusercontent.com/71986226/217224634-dbfd5ad9-6215-4545-89e5-818c8222a580.png">
</td>
<td>
<img src="https://user-images.githubusercontent.com/71986226/217224649-b1e83f5a-943d-4b2d-80d2-4eb6a8cc0665.png">
</td>

</tr>
</table>

### De-modulation: 

<ol>
<li>
Calculate demodulated signal by multiplying carrier and modulation signal
</li>
<li>
Calculate low pass filter used frequency sampling.
</li>
<li>
Perform demodulation three times with phase shifts of 10, 30, 90 degrees for both carriers 

> **Note**: (before each phase shift calculate carrier phase).
</li>
<li>
Perform demodulation two times with a local carrier frequency that is different by 2 Hz and 10 Hz from its carrier frequency.
</li>
</ol>

<table>
<tr>
<td>
<img  src="https://user-images.githubusercontent.com/71986226/217225512-9a5e7d8b-e78a-4d59-b8e9-c370c574b941.png">
</td>
<td>
<img src="https://user-images.githubusercontent.com/71986226/217225595-af0d2f40-ce55-4746-a317-6124d61ce782.png">
</td>
<td>
<img src="https://user-images.githubusercontent.com/71986226/217225664-254a6957-a752-4e92-92b1-c151f4430710.png">
</td>

</tr>
</table>
<hr style="background-color: #4b4c60"></hr>


<a id ="Contributors"></a>

## <img  align="center" width= 70px height =55px src="https://media0.giphy.com/media/Xy702eMOiGGPzk4Zkd/giphy.gif?cid=ecf05e475vmf48k83bvzye3w2m2xl03iyem3tkuw2krpkb7k&rid=giphy.gif&ct=s"> Contributors

<br>
<table >
  <tr>
        <td align="center"><a href="https://github.com/ZiadSheriif"><img src="https://avatars.githubusercontent.com/u/78238570?v=4" width="150px;" alt=""/><br /><sub><b>Ziad Sherif </b></sub></a><br /></td>
        <td align="center"><a href="https://github.com/EslamAsHhraf"><img src="https://avatars.githubusercontent.com/u/71986226?v=4" width="150px;" alt=""/><br /><sub><b>Eslam Ashraf</b></sub></a><br /></td>
  </tr>
</table>

<hr style="background-color: #4b4c60"></hr>

<a id ="License"></a>

## 🔒 License

> **Note**: This software is licensed under MIT License, See [License](https://github.com/ZiadSheriif/SAMA3NY/blob/main/LICENSE) for more information ©Ziad Sherif .
