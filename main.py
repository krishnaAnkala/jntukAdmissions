from wsgiref.util import request_uri
from flask import *
import pandas as pd
from flask_mysqldb import MySQL
import MySQLdb.cursors
import re 
import os
import json
from werkzeug.security import generate_password_hash, check_password_hash
from flask_mail import Mail,Message
import random


UPLOAD_CERTIFICATE ='./static/files/Certificates/'
UPLOAD_FOLDER = './static/files/'
ALLOWED_EXTENSIONS = {"xlsx","xsl"}

app=Flask(__name__)
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

app.secret_key = '1a2b3c4d5e'

# Enter your database connection details below
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'db'
mysql = MySQL(app)


#mail variables
with open('config.json','r') as f:
    credentials=json.load(f)['credentials']

app.config['MAIL_SERVER'] = 'smtp.gmail.com'
app.config['MAIL_PORT'] =465
app.config['MAIL_USERNAME'] = credentials['user-id']
app.config['MAIL_PASSWORD'] =credentials['pwd']
app.config['MAIL_DEFAULT_SENDER'] = credentials['user-id']
app.config['MAIL_USE_TLS'] = False
app.config['MAIL_USE_SSL'] = True
mail=Mail(app)


def sendmail(subject,recipients,body):
    try:
        msg=Message()   
        msg.subject=subject
        msg.recipients=[recipients]
        msg.html =body
        mail.send(msg)
    except Exception as e:
        return

@app.route('/')
def welcome():
    return render_template('index.html',account=session,title="Home")

@app.route('/signin',methods=['GET', 'POST'])
def login():
    if not 'loggedin' in session:
        try:
            if request.method == 'POST' and 'username' in request.form and 'password' in request.form:
                # Create variables for easy access
                username = request.form['username']
                password = request.form['password']
                cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)   
                cursor.execute('SELECT * FROM accounts WHERE username = %s', [username])
                account = cursor.fetchone()
                if(account):
                    if account['Active']==False:
                        flash("Your Account is Not Activated","danger")
                    elif check_password_hash(account['password'], password):
                        session['loggedin'] = True
                        session['name']=account['name']
                        session['id'] = account['id']
                        session['userType'] = account['userType']
                        session['username'] = account['username']
                        session['clgName'] = account['clgName']
                        # Redirect to home page
                        return redirect(url_for('home'))                
                    else:
                        # Account doesnt exist or username/password incorrect
                        flash("Incorrect username/password!", "danger")
                else:
                    flash("User Not Exists", "danger")
            return render_template('auth/login.html',account=session,title="Login")
        except:
            flash("Something Wrong", "danger")         
            return redirect(url_for('login')) 
    else:
        return redirect(url_for('profile'))


@app.route('/signup', methods=['GET', 'POST'])
def register():
        if request.method == 'POST' and 'username' in request.form and 'password' in request.form and 'email' in request.form:
            try:               
                colleges = request.form.getlist('colleges')                
                name=request.form['name']
                userType=request.form['userType']
                clgName=request.form['clgName']
                username = request.form['username']
                password = request.form['password']
                email = request.form['email']
                active=0
                cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
                cursor.execute("SELECT * FROM accounts WHERE username LIKE %s",[username])
                account = cursor.fetchone()
                if account:
                    flash("Account already exists!", "danger")
                elif not re.match(r'[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}', email):
                    flash("Invalid email address!", "danger")                
                else:
                    try:
                        if 'loggedin' in session and session['userType']=='Admin':
                            active=1
                        cursor.execute('INSERT INTO accounts VALUES (NULL,%s, %s, %s, %s,%s,%s,%s,%s)', (name,userType,clgName,username,email,generate_password_hash(password,method="sha256"),active,0))
                        mysql.connection.commit()
                        id=cursor.lastrowid
                        try:
                            if(request.form['userType']=='Verifier'):
                                for college in colleges:
                                    cursor.execute('INSERT INTO clerk_colleges VALUES (NULL,%s, %s)', (id,college))
                                    mysql.connection.commit()
                            flash("Account registered successfully !", "success")
                            if 'loggedin' not in session:
                                body="Your account <b>created successfully</b>,but not yet activated.<br/>Your account will be activated once you are verified.<br/> User Name:"+username
                                sendmail("Account Created",email,body)
                                return redirect(url_for('login'))
                            else:
                                body="Your account <b>created and activated successfully</b>.<br/> User Name:"+username
                                sendmail("Account Created",email,body)
                                if(request.form['userType']=='Verifier'):
                                    return redirect(url_for('verifier_register'))   
                                else:  
                                    return redirect(url_for('admin_register'))                        
                        except Exception as  e:
                            cursor.execute('DELETE FROM accounts WHERE id=%s',(id,))
                            mysql.connection.commit()   
                            cursor.close()
                            flash("Something Wrong", "danger")
                            return redirect(url_for('verifier_register'))         
                    except : 
                        flash("Something Wrong", "danger")                                          
                        return redirect(url_for('register')) 
            except:
                flash("Something Wrong", "danger")                                          
                return redirect(url_for('register'))       
        elif request.method == 'POST':            
            flash("Please fill out the form!", "danger")
                    
        return render_template('auth/register.html',account=session,title="Register")    

@app.route('/verifier_register')
def verifier_register():
    if 'loggedin' in session and session['userType']=='Admin':
        try:
            return render_template('auth/verifier_register.html', account=session,title="Verifier Register")
        except:
            flash("Something Wrong", "danger")
            return redirect(url_for('login'))
    # User is not loggedin redirect to login page
    return redirect(url_for('login')) 

@app.route('/admin_register')
def admin_register():
    if 'loggedin' in session and session['userType']=='Admin':
        try:
            return render_template('auth/admin_register.html', account=session,title="New Admin Register")
        except:
            flash("Something Wrong", "danger")
            return redirect(url_for('login'))
    # User is not loggedin redirect to login page
    return redirect(url_for('login')) 


@app.route('/forgotpassword',methods=['GET', 'POST'])
def forgotpassword():
    if not 'loggedin' in session:
        
        if request.method == 'POST' and request.form['uname']!='' and 'email' in request.form:
            try:
                otp=random.randint(1000,9999)
                mycur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
                mycur.execute('SELECT * FROM accounts WHERE username = %s', [request.form['uname']])
                account = mycur.fetchone()
                
                if(account):
                    mycur.execute('SELECT * FROM accounts WHERE username = %s and email=%s', (request.form['uname'],request.form['email']))
                    account = mycur.fetchone()
                    if(account):
                        mycur.execute('UPDATE accounts SET otp=%s  WHERE username=%s and email=%s',(otp,request.form['uname'],request.form['email']))
                        mysql.connection.commit()  
                        sendmail("OTP",request.form['email'],'OTP:'+ str(otp))   
                    else:
                        return jsonify({'msg':'Email Does Not Match!!'})      
                    return jsonify({'otp' : 'success','uname':request.form['uname']})
                else:
                    return jsonify({'msg':'Username Not Exists'})
            except Exception as e:
                return jsonify({'msg':'SOMETHING WRONG'})
        elif  request.method=='POST'  and 'otp' in request.form and  request.form['uname']!='': 
            try:
                mycur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
                mycur.execute("SELECT otp from accounts where username= %s",(request.form['uname'],))
                otpAccount = mycur.fetchone()
                if int(request.form['otp'])==int(otpAccount['otp']):
                    if request.form['cnfrmpassword']!=request.form['password']:
                        return  jsonify({'msg' :"Password and Confirm Password Doesn't Match"})
                    mycur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
                    mycur.execute('UPDATE accounts SET otp=%s,password=%s  WHERE username=%s',('',generate_password_hash(request.form['password']),request.form['uname']))
                    mysql.connection.commit()
                    jsonify({'success':True})
                    flash("Password Updated Successfully",'success')
                    return  jsonify({'success' :1,'url':'/signin'})
                return jsonify({'error' :1})
            except Exception as e: 
                return  jsonify({'msg' :'SOMETHING WRONG'})
        elif  request.method=='POST':
            return jsonify({'msg':'Invalid Data'})               
        else:
            return render_template('auth/forgotPassword.html',account=session,title="Forgot Password")
    else:
        return redirect(url_for('profile'))
@app.route('/home')
def home():
    if 'loggedin' in session:
        try:    
            # User is loggedin show them the home page
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute('SELECT * FROM accounts WHERE id = %s', (session['id'],))
            account = cursor.fetchone()
            return render_template('home/home.html',account=session,title="Home")
        except:
            flash("Something Wrong", "danger")
    # User is not loggedin redirect to login page
    return redirect(url_for('login'))    

@app.route('/profile')
def profile():
    # Check if user is loggedin
    if 'loggedin' in session:
        try:
            # User is loggedin show them the home page
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute('SELECT * FROM accounts WHERE id = %s', (session['id'],))
            account = cursor.fetchone()
            return render_template('auth/profile.html', account=session,auth=account,title="Profile")
        except:
            flash("Something Wrong", "danger")
            return redirect(url_for('login'))
    # User is not loggedin redirect to login page
    return redirect(url_for('login'))  

       
@app.route('/logout')
def logout():
    # Check if user is loggedin
    if 'loggedin' in session:
        session.clear()
    return redirect(url_for('welcome'))
   
@app.route('/dashboard')
def dashboard():
    if  'loggedin' in session and session['userType']=='User':
        try:
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute('SELECT branch,count(roll_no) as rno_count FROM student WHERE clgName=%s group by branch',(session['clgName'],))
            data = cursor.fetchall()
            branch_bar=[]
            stud_count__bar=[]
            for k in data:
                branch_bar.append(k['branch'])
                stud_count__bar.append((k['rno_count']))
                
            cursor.execute('SELECT branch,emcet,count(roll_no) as std_count FROM student WHERE clgName=%s group by branch HAVING emcet<1000 ',(session['clgName'],))
            data = cursor.fetchall()
            branch_line=[]
            stud_count_line=[]
            for k in data:
                branch_line.append(k['branch'])
                stud_count_line.append((k['std_count']))
            
            cursor.execute('SELECT reservation,count(roll_no) as std_count FROM student WHERE clgName=%s group by reservation',(session['clgName'],))
            data = cursor.fetchall()
            reservation_pie=[]
            stud_count_pie=[]
            for k in data:
                reservation_pie.append(k['reservation'])
                stud_count_pie.append((k['std_count']))
            cursor.execute('SELECT name,ssc  FROM student WHERE clgName=%s',(session['clgName'],))
            data = cursor.fetchall()
            
            return render_template('user/dashboard.html',branch_bar=json.dumps(branch_bar),stud_count__bar=json.dumps(stud_count__bar),reservation_pie=json.dumps(reservation_pie),stud_count__pie=json.dumps(stud_count_pie),branch_line=json.dumps(branch_line),stud_count_line=json.dumps(stud_count_line),account=session,title="Dashboard")
        except:
            flash("Something Wrong", "danger")
            return redirect(url_for('login'))
    else:
        return redirect(url_for('login'))

@app.route('/activateAccount',methods=['GET', 'POST'])
def activateAccount():
    # Check if user is loggedin
    if 'loggedin' in session and session['userType']=='Admin':
        if request.method == 'POST':
            try:
                cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
                cursor.execute('UPDATE accounts SET Active=%s  WHERE username=%s',(request.form['activeVale'],request.form['uname']))
                mysql.connection.commit()
                cursor.close()
                if request.form['activeVale']=='1':
                    body="Your account <b>activated</b> successfully.<br/> User Name:"+request.form['uname']
                    sendmail("Account activated",request.form['email'],body)
                return jsonify({'success':1,'msg' : 'Success'})
            except:
               return jsonify({'error':1,'msg' : 'Something Wrong'}) 
        else:
            try:
                cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
                cursor.execute('SELECT * from accounts where Active="False"')
                data = cursor.fetchall()
                accountsNotActivated={}
                for i in data:
                    accountsNotActivated[i['id']]=(i['name'],i['clgName'],i['username'],i['email'],i['Active'])
                cursor.close()
                return render_template('auth/activateAccount.html', account=session,title="Activate Account",accountsNotActivated=accountsNotActivated)
            except:
                return jsonify({'msg' : 'Something Wrong'})

    return redirect(url_for('login'))

@app.route('/deleteAccount',methods=['POST'])
def deleteAccount():
    # Check if user is loggedin
    if 'loggedin' in session and session['userType']=='Admin':
        if request.method == 'POST':
            try:
                cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
                cursor.execute('delete from accounts WHERE username=%s and name=%s and email=%s',(request.form['uname'],request.form['name'],request.form['email']))
                mysql.connection.commit()
                cursor.close()
                # if request.form['activeVale']=='1':
                #     body="Your account <b>activated</b> successfully.<br/> User Name:"+request.form['uname']
                #     sendmail("Account activated",request.form['email'],body)
                return jsonify({'success':1,'msg' : 'Deleted'})
            except Exception as e:
                return jsonify({'error':1,'msg' : 'Something Wrong'}) 
    return redirect(url_for('login'))
      
#for Uploading
@app.route('/uploadData', methods=['GET', 'POST'])
def uploadData():
    try:
        if 'loggedin' in session and session['userType']=='User'and request.method == 'POST' :
            
            studetails = request.form
            name =  studetails['name']
            rno =  studetails['rno']
            acaYear=studetails['acaYear']
            clgName=session['clgName']
            emrank =  studetails['emrank'] 
            ssc =  studetails['ssc']
            inter =  studetails['inter']
            branch =  studetails['branch']
            res =  studetails['res']
            wcard =  studetails['wcard']
            docStatus=studetails['docStatus']
            file = request.files['upload-pdf']
            file.save(os.path.join(UPLOAD_CERTIFICATE,rno+'.pdf'))
            filename=UPLOAD_CERTIFICATE+'/'+rno+'.pdf'
            mycur = mysql.connection.cursor()
            mycur.execute("INSERT INTO student(name,roll_no,acaYear,clgName,emcet,ssc,inter,branch,reservation,whitecard,docStatus,Certificates) VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",(name,rno,acaYear,clgName,emrank,ssc,inter,branch,res,wcard,docStatus,filename))
            mysql.connection.commit()
            flash("Student Data Uploaded successfully", "success")
            return redirect(url_for('uploadData'))
        elif 'loggedin' in session and session['userType']=='User':
            return render_template('user/uploadData.html', account=session,title="Upload")
        else:
            return redirect(url_for('login'))
    except Exception as e:
        flash("Invalid Data "+str(e), "danger")
        return redirect(url_for('uploadData'))
 
@app.route('/getColleges',methods=['POST'])
def getColleges():
    try:
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute("SELECT clgName FROM colleges")
            colleges =cursor.fetchall()
            allcolleges=[]
            for i in colleges:
                allcolleges.append(i['clgName'])
            cursor.close()
            return jsonify({'success':1,'colleges' :allcolleges,'msg':'Success'})
    except Exception as e:
            return jsonify({'error':1,'msg' : 'Something went Wrong!!'})

@app.route('/getVerifierColleges',methods=['POST'])
def getVerifierColleges():
    try:
            clerk_id=request.form['clerk_Id']
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute("SELECT clgName FROM clerk_colleges where clerk_id=%s",(clerk_id,))
            colleges =cursor.fetchall()
            allcolleges=[]
            for i in colleges:
                allcolleges.append(i['clgName'])
            cursor.close()
            return jsonify({'success':1,'colleges' :allcolleges,'msg':'Success'})
    except Exception as e:
            return jsonify({'error':1,'msg' : 'Something went Wrong!!'})
        
@app.route('/getStudents',methods=['POST'])
def getStudents():
    try:
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        clgName=request.form['clgName']
        acaYear=request.form['acaYear']
        cursor.execute("SELECT * FROM student WHERE clgName=%s and acaYear=%s",(clgName,acaYear))
        students =cursor.fetchall()
        allstudents=[]
        for i in students:
            allstudents.append({'name':i['name'],'rno':i['roll_no'],'branch':i['branch'],'docStatus':i['docStatus'],'reason':i['reason']})
        cursor.close()
        return jsonify({'success':1,'students' :allstudents,'msg':'Success'})
    except Exception as e:
            return jsonify({'error':1,'msg' : 'Something went Wrong!!'})   

#for displaying
@app.route('/studentData')
def studentData():
    # Check if user is loggedin
    if 'loggedin' in session :
        try:
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute("SELECT name,roll_no,branch,docStatus,reason FROM student where clgName=%s",(session['clgName'],))
            students = cursor.fetchall()
            data_of_students=[]
            for i in students:
                data_of_students.append({'name':i['name'],'rno':i['roll_no'],'branch':i['branch'],'docStatus':i['docStatus'],'reason':i['reason']})
            return render_template('user/studentData.html', account=session,title="Student Data",data_of_students=data_of_students)
        except Exception as e:
            flash("Something Wrong", "danger")
    # User is not loggedin redirect to login page
    return redirect(url_for('login'))

@app.route('/verifier')
def verifier():
    if 'loggedin' in session and session['userType']=='Verifier':
        try:            
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute("SELECT clgName FROM clerk_colleges where clerk_id=%s",(session['id'],))
            colleges =cursor.fetchall()
            clgs=[]
            for i in colleges:
                clgs.append(i['clgName'])
            cursor.execute('''SELECT name,roll_no,clgName FROM student WHERE docStatus="Pending" AND clgName IN %(clgs)s''', {'clgs': tuple(clgs)}) 
            data = cursor.fetchall()
            
            data_of_students={}
            for i in data:
                data_of_students[i['roll_no']]=[i['name'],i['roll_no'],i['clgName']]
            cursor.close()
        except Exception as e:
            flash('Something Wrong','danger')
            return redirect(url_for('login'))
        return render_template('verifier/verifier.html', account=session,title="Verifier",data_of_students=data_of_students)
    # User is not loggedin redirect to login page
    return redirect(url_for('login'))

@app.route('/Verifier_Update_Docstatus',methods=['POST'])
def Verifier_Update_Docstatus():
    try:
        if 'loggedin' in session and session['userType']=='Verifier':
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            rno=request.form['rno']
            name=request.form['name']
            docStatus=request.form['docStatus']
            reason=request.form['reason']
            cursor.execute('UPDATE student SET docStatus=%s,reason=%s WHERE roll_no=%s and name=%s',(docStatus,reason,rno,name))
            mysql.connection.commit()
            cursor.close() 
            return jsonify({'success':1,'msg' : 'Success!!'}) 
    except Exception as e:
        return jsonify({'error':1,'msg' : 'Something went Wrong!!'})


# for Xldata upload
'''
@app.route('/xldata', methods=['GET', 'POST'])
def xldata():
    try:
        if request.method == 'POST':            
            file = request.files['upload-file']
            file.save(os.path.join(app.config['UPLOAD_FOLDER'],file.filename))
            filename=UPLOAD_FOLDER+'/'+file.filename
            data = pd.read_excel(filename)
            os.remove(filename)
            x=data.set_index('s_no').T.to_dict('list')
            mycur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            for i in x.values():
                name,rno,acaYear,clgName,emrank,ssc,inter,branch,res,wcard=i[0],i[1],i[2],i[3],i[4],i[5],i[6],i[7],i[8],i[9]
                docStatus='Pending'
                filename=UPLOAD_CERTIFICATE+'/'+rno+'.pdf'
                mycur.execute("INSERT INTO student(name,roll_no,acaYear,clgName,emcet,ssc,inter,branch,reservation,whitecard,docStatus,Certificates) VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",(name,rno,acaYear,clgName,emrank,ssc,inter,branch,res,wcard,docStatus,filename))
            mysql.connection.commit()    
            mycur.close()
            flash("Excel Data Uploaded successfully", "success")
            return redirect(url_for('login'))
        else:
             return render_template('user/uploadData.html', account=session,title="Upload")
    except Exception as e:
        flash("Error", "error")
        return redirect(url_for('login'))
'''
@app.route('/xldata', methods=['GET', 'POST'])
def xldata():
    try:    
        if request.method == 'POST':        
            file = request.files['upload-file']
            file.save(os.path.join(UPLOAD_CERTIFICATE,'18021A0520.pdf'))
            for i in range(501,519):
                file.save(os.path.join(UPLOAD_CERTIFICATE,'19025A0'+str(i)+".pdf"))
            for i in range(555,654):
                file.save(os.path.join(UPLOAD_CERTIFICATE,'19025A0'+str(i)+".pdf"))
            return redirect(url_for('login'))
        else:
             return render_template('user/uploadData.html', account=session,title="Upload")
            
    except Exception as e:
        flash("Error", "error")
        print(str(e))
        return redirect(url_for('login'))

# Sample data upload from xl
'''
@app.route('/data', methods=['GET', 'POST'])
def data():
    if request.method == 'POST':
        file = request.form['upload-file']
        data = pd.read_excel(file)
        # x=data.set_index('x1').T.to_dict('list')
        # for i in x.values():
        #     mycur.execute("INSERT INTO user(x,y,z) VALUES(%s,%s,%s)",(i[0],i[1],i[2]))
        # mydb.commit()
        return render_template('data.html', data=data.to_dict())
'''
# Sample Chart Visualization
'''
@app.route('/sampleChart')
def sampleChart():
        return render_template('sampleChart.html')    

'''
    
if __name__ =='__main__':
    app.run(debug=True)    
