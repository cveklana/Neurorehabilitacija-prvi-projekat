function varargout = Projekat1(varargin)
% PROJEKAT1 MATLAB code for Projekat1.fig
%      PROJEKAT1, by itself, creates a new PROJEKAT1 or raises the existing
%      singleton*.
%
%      H = PROJEKAT1 returns the handle to a new PROJEKAT1 or the handle to
%      the existing singleton*.
%
%      PROJEKAT1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJEKAT1.M with the given input arguments.
%
%      PROJEKAT1('Property','Value',...) creates a new PROJEKAT1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Projekat1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Projekat1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Projekat1

% Last Modified by GUIDE v2.5 11-Mar-2023 16:39:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Projekat1_OpeningFcn, ...
                   'gui_OutputFcn',  @Projekat1_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Projekat1 is made visible.
function Projekat1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Projekat1 (see VARARGIN)

% Choose default command line output for Projekat1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Projekat1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Projekat1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_ucitavanje.
function pushbutton_ucitavanje_Callback(hObject, eventdata, handles)
%run("Zadatak1.m")
%run("Zadatak12.m")
%%
load('EMGdata-obuka.mat')
%%
%imace onoliko vrsta koliko imamo obelezja i kolona koliko imamo prozor
v_obuka = []; %broj vektora za   visi od broja prozora sa kojima segmentiramo
klase_obuka = []; 

poceci = 1:250:length(CHS_vezbe);
%%
%imamo onoliko iteracija koliko imamo prozora
for i = 1:length(poceci)-2
    
    %indeks pocetka poslednjeg proyora do sad nije bio na dovoljnom rastojanju do kraja niza
    
        pocetak = poceci(i);
        prozor_klase = grasp_type_vezbe(:,pocetak:pocetak+499); %1x500

    if length(unique(prozor_klase)) == 1 %junik vraća vektor broja članova, ako je broj različit od dva nastavljamo dalje

        prozor_emg = CHS_vezbe(:, pocetak:pocetak+499); 

        %length(unique(prozor_klase)) =1%ispituje da li postoji jedna jedinstvena vrednost u prozoru sa klasama

        klasa=prozor_klase(1); %u [prozoru klase se nalazi taj jedan broj koji oznacava sta korisnik radi
        %u prozou nad klasama se jedinica pojavi 500 puta
    
        % Izdvajanje obelezja iz prozor_emg, jedan prozor vraca vektor dimenzija
        % 1x24
    
        %jedan vektor obelezja cine RMS WL i MAV sve izvuceno na svim kanalima
        % 1x24 =[1x8 1x8 1x8]
    
         rms_ob = rms(prozor_emg, 2); %za svaki prozor jedno rms
         wl_ob= sum(abs(diff(prozor_emg,1,2)),2); %prvog reda i na vrstana
         %suma mora ima argument dva kako bi on samo drugi broj sumiro
         mav_ob = mean(abs(prozor_emg),2); %2 - po vrstama
         v_obelezja = [rms_ob; wl_ob; mav_ob];
         v_obuka = [v_obuka v_obelezja]; %train!!!
         klase_obuka= [klase_obuka klasa]; %klase na kojoj treba!!

         %oznaku klase za dati deo obelezja izvlacimo iz prozora sa klasama koji
         %je dimenzija 1x500
    end
 end
%%     
%%
load('EMGdata-test.mat')
%%
%imace onoliko vrsta koliko imamo obelezja i kolona koliko imamo prozor
v_test = []; %broj vektora za   visi od broja prozora sa kojima segmentiramo
klasa_test = []; 

poceci2 = 1:250:length(CHS_provera);
%%
%imamo onoliko iteracija koliko imamo prozora
for i = 1:length(poceci2)-2
    
    %indeks pocetka poslednjeg proyora do sad nije bio na dovoljnom rastojanju do kraja niza
    
        pocetak2 = poceci2(i);
        prozor_klase2 = grasp_type_provera(:,pocetak2:pocetak2+499); %1x500

    if length(unique(prozor_klase2)) == 1 %junik vraća vektor broja članova, ako je broj različit od dva nastavljamo dalje

        prozor_emg2 = CHS_provera(:, pocetak2:pocetak2+499); 

        %length(unique(prozor_klase)) =1%ispituje da li postoji jedna jedinstvena vrednost u prozoru sa klasama

        klasa=prozor_klase2(1); %u [prozoru klase se nalazi taj jedan broj koji oznacava sta korisnik radi
        %u prozou nad klasama se jedinica pojavi 500 puta
    
        % Izdvajanje obelezja iz prozor_emg, jedan prozor vraca vektor dimenzija
        % 1x24
    
        %jedan vektor obelezja cine RMS WL i MAV sve izvuceno na svim kanalima
        % 1x24 =[1x8 1x8 1x8]
    
         rms_ob2 = rms(prozor_emg2, 2); %za svaki prozor jedno rms
         wl_ob2= sum(abs(diff(prozor_emg2,1,2)),2); %prvog reda i na vrstana
         %suma mora ima argument dva kako bi on samo drugi broj sumiro
         mav_ob2 = mean(abs(prozor_emg2),2); %2 - po vrstama
         v_obelezja2 = [rms_ob2; wl_ob2; mav_ob2];
         v_test = [v_test v_obelezja2]; %TEST!!!
         klasa_test= [klasa_test klasa]; %klase na kojoj treba!!
         
         %oznaku klase za dati deo obelezja izvlacimo iz prozora sa klasama koji
         %je dimenzija 1x500
    end
end
      
global v_test
global v_obuka
global klase_obuka
global klas
global klasa_test

msgbox('is done')

% doooooovdeeee

handles.output = hObject;
guidata(hObject, handles);

% --- Executes on button press in pushbutton_tacnost.
function pushbutton_tacnost_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_tacnost (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global klas
global v_test
global v_obuka
global klase_obuka
global klasa_test

%PROBAM

dugme1=get(handles.radiobutton_linear, 'Value');
dugme2= get(handles.radiobutton3, 'Value');
dugme3 = get(handles.radiobutton_quadratic, 'Value');

global v_test
global v_obuka
global klase_obuka


if  dugme1== 1
    k = 'linear';

elseif dugme2 == 1
    k = 'diaglinear';

elseif dugme3 == 1
    k = 'quadratic';
end

klase_koje_smo_dobili = classify(v_test', v_obuka', klase_obuka, k);
msgbox('Odradjeno')


%tacno_klasifikovani = strcmp(klase_koje_smo_dobili, klasa_test) 
%broj_tacno_klasifikovanih = sum(tacno_klasifikovani)
%procenat_tacnosti = 100* broj_tacno_klasifikovanih/length(klase_koje_smo_dobili)
%procenat= num2str(procenat_tacnosti);
%set(handles.edit1, 'String', procenat_tacnosti)
klase_koje_smo_dobili = klase_koje_smo_dobili';
n = length(klasa_test);
n_tacnih_predvidjanja = sum(klasa_test == klase_koje_smo_dobili);
tacnost = n_tacnih_predvidjanja / n;
set(handles.edit1, 'String', sprintf(' %.2f%%', tacnost*100));


cm = confusionmat(klasa_test,klase_koje_smo_dobili);
uitable_matrica_konfuzije.RowName = {'Predviđene vrednosti klasa'};

set(handles.uitable_matricakonfuzije, 'Data', cm)

handles.output = hObject;
guidata(hObject, handles);



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function uibuttongroup1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uibuttongroup1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


%klase_test_dobijeno = cell(length(klase_test), 1)   
%for i = 1:length(klase_test)
  %  dobijena_test_klasa = classify(test_uzorci(i,:),obuka_uzorci,klase_obuka) %jedan po jedan test uzorak i ceo set za obuku
 %   klase_test_dobijeno(i) = dobijena_test_klasa;                                                             
%end


% --- Executes when selected object is changed in uibuttongroup1.
function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup1 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



    


% --- Executes during object creation, after setting all properties.
function radiobutton_linear_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radiobutton_linear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in radiobutton_linear.
function radiobutton_linear_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_linear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_linear


% --- Executes on button press in radiobutton_quadratic.
function radiobutton_quadratic_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_quadratic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_quadratic


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3
