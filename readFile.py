'''
Created on Dec 14, 2016

@author: fabio-teixeira
'''
import json
import datetime
from pprint import pprint


def openFile(file):
    with open(file) as data_file:
        data = json.load(data_file)
    return data

def patternSetFields(totvsFile = 'sample.txt', tabularFile = "customerWillSpendTabular.txt"):
    fo = open(tabularFile, "wb")
    fo.write(bytes('valorTotal' + ";" +
                   'ide_dhEmi_$date' + ";" +
                   'ide_natOp' +';'+
                   'infAdic_infCpl' +';'+
                   'total_icmsTot_vDesc' +';'+
                   'total_icmsTot_vFrete' +';'+
                   'total_icmsTot_vOutro' +';'+
                   'total_icmsTot_vProd' +';'+
                   'total_icmsTot_vSeg' +';'+
                   'total_icmsTot_vTotTrib' +';'+
                   'total_icmsTot_vbc' +';'+
                   'total_icmsTot_vbcst' +';'+
                   'total_icmsTot_vcofins' +';'+
                   'total_icmsTot_vicms' +';'+
                   'total_icmsTot_vicmsDeson' +';'+
                   'total_icmsTot_vii' +';'+
                   'total_icmsTot_vipi' +';'+
                   'total_icmsTot_vnf' +';'+
                   'total_icmsTot_vpis' +';'+
                   'total_icmsTot_vst' +';'+                               
                   'nItem' +';'+
                   'prod_indTot' +';'+
                   'prod_qCom' +';'+
                   'prod_uCom' +';'+
                   'prod_vProd' +';'+
                   'prod_vUnCom' +';'+
                   'prod_xProd' + '\n' , 'UTF-8'))
    
    data = openFile(totvsFile)
    for x in data:
        for y in x['dets']:
            fo.write(bytes(
                           str(x['complemento']['valorTotal']) + ";" + 
                           str(x['ide']['dhEmi']['$date']) + ";" +
                           str(x['ide']['natOp']) +';'+
                           str(x['infAdic']['infCpl']) +';'+
                           str(x['total']['icmsTot']['vDesc']) +';'+
                           str(x['total']['icmsTot']['vFrete']) +';'+
                           str(x['total']['icmsTot']['vOutro']) +';'+
                           str(x['total']['icmsTot']['vProd']) +';'+
                           str(x['total']['icmsTot']['vSeg']) +';'+
                           str(x['total']['icmsTot']['vTotTrib']) +';'+
                           str(x['total']['icmsTot']['vbc']) +';'+
                           str(x['total']['icmsTot']['vbcst']) +';'+
                           str(x['total']['icmsTot']['vcofins']) +';'+
                           str(x['total']['icmsTot']['vicms']) +';'+
                           str(x['total']['icmsTot']['vicmsDeson']) +';'+
                           str(x['total']['icmsTot']['vii']) +';'+
                           str(x['total']['icmsTot']['vipi']) +';'+
                           str(x['total']['icmsTot']['vnf']) +';'+
                           str(x['total']['icmsTot']['vpis']) +';'+
                           str(x['total']['icmsTot']['vst']) +';'+                               
                           str(y['nItem']) +';'+
                           str(y['prod']['indTot']) +';'+
                           str(y['prod']['qCom']) +';'+
                           str(y['prod']['uCom']) +';'+
                           str(y['prod']['vProd']) +';'+
                           str(y['prod']['vUnCom']) +';'+
                           str(y['prod']['xProd'] + '\n') , 'UTF-8'))
                                       
    fo.close()
    
def salesForecastNextWeek(totvsFile = 'sample.txt', tabularFile = "saleForecastTabular.txt"):
    fo = open(tabularFile, "wb")
    fo.write(bytes('valorTotal' + ";" +
                   'ide_dhEmi_date' + ";" +
                   'weekNumber' +  
                   '\n' , 'UTF-8'))
    
    data = openFile(totvsFile)
    for x in data:
        #"2016-01-23T14:56:35.000Z"                
        fo.write(bytes(str(x['complemento']['valorTotal']) + ";" +
                       str(x['ide']['dhEmi']['$date']) + ";" + 
                       str(datetime.datetime.strptime(str(x['ide']['dhEmi']['$date']), "%Y-%m-%dT%H:%M:%S.%fZ").date().isocalendar()[1]) + 
                       '\n' , 'UTF-8'))
                                       
    fo.close()
        
if __name__ == '__main__':
    
    print('Start')    
    patternSetFields("sample.txt", "customerWillSpendTabular.txt")
    salesForecastNextWeek("sample.txt", 
                          "saleForecastTabular.txt")
    print('Finish')
    
    
    
    
    