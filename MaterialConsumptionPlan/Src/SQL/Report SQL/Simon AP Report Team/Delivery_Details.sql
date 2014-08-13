(SELECT DELIVERY, FROM INV_SAP_LIKP_LIPS_DAILY WHERE PLANTID = '5200')


CREATE TABLE INV_SAP_LIKP_LIPS_DAILY AS 
SELECT * FROM DWQ$LIBRARIAN.INV_SAP_LIKP_LIPS_DAILY@ROCKWELL_DBLINK WHERE PLANTID = '1090' AND INCOTERMS2 = 'Shanghai';

SELECT DELIVERY,
DELIVERY_ITEM,
CREATED_BY,
CREATED_TIME,
CREATED_ON_DATE,
MATERIALID,
PLANTID,
CATALOGID,
MVMT_TYPE,
DELIVERY_QTY_SUOM,
BASE_UOM,
SALES_UOM,
NUMERATOR,
DENOMINATOR,
MATERIAL_AVAIL_DATE,
REFERENCE_DOC,
REFERENCE_DOC_ITEM,
REFERENCE_DOC_TRIM,
REFERENCE_DOC_ITEM_TRIM,
DELIVERY_TYPE,
UPC,
INCOTERMS1,
INCOTERMS2,
DELIVERY_PRIORITY,
CHANGED_ON_DATE,
ACT_GI_DATE,
DWQ_SRC_EXTRACT_DATE,
DELIVERY_QTY_STO_ITEM
FROM INV_SAP_LIKP_LIPS_DAILY WHERE DELIVERY IN ('8013781936',
'8013781937',
'8013781938',
'8013781939',
'8013781940',
'8013781941',
'8013781942',
'8013781943',
'8013781944',
'8013781945',
'8013781946',
'8013781947',
'8013781948',
'8013781949',
'8013781950',
'8013781951',
'8013781952',
'8013781953',
'8013781954',
'8013781955',
'8013781956',
'8013781957',
'8013781958',
'8013781959',
'8013781960',
'8013781961',
'8013781962',
'8013781963',
'8013781964',
'8013781965',
'8013781966',
'8013781967',
'8013781968',
'8013781969',
'8013781970',
'8013781971',
'8013781972',
'8013781973',
'8013781974',
'8013781975',
'8013781976',
'8013781977',
'8013781978',
'8013781979',
'8013781980',
'8013781982',
'8013781983',
'8013781984',
'8013781985',
'8013781986',
'8013781987',
'8013781988',
'8013781989',
'8013781990',
'8013781991',
'8013781993',
'8013781994',
'8013781995',
'8013781996',
'8013781997',
'8013781998',
'8013781999',
'8013782000',
'8013782001',
'8013782002',
'8013782003',
'8013782004',
'8013782005',
'8013782006',
'8013782007',
'8013782008',
'8013782009',
'8013782010',
'8013782011',
'8013782012',
'8013782014',
'8013782015',
'8013782016',
'8013782017',
'8013782018',
'8013782019',
'8013782020',
'8013782021',
'8013782022',
'8013782023',
'8013782024',
'8013782025',
'8013782026',
'8013782027',
'8013782028',
'8013782029',
'8013782030',
'8013782031',
'8013782032',
'8013782033',
'8013782034',
'8013782035',
'8013782036',
'8013782037',
'8013782038',
'8013782039',
'8013782040',
'8013782041',
'8013782042',
'8013782043',
'8013782044',
'8013782045',
'8013793140',
'8013793141',
'8013793142',
'8013793143',
'8013848623',
'8013806056',
'8013806058',
'8013806059',
'8013806060',
'8013806061',
'8013806063',
'8013806064',
'8013806065',
'8013806066',
'8013806651',
'8013806652',
'8013806653',
'8013807334',
'8013807335',
'8013807337',
'8013807338',
'8013807661',
'8013807662',
'8013807663',
'8013807664',
'8013808231',
'8013808232',
'8013808233',
'8013808234',
'8013808235',
'8013808236',
'8013808237',
'8013809150',
'8013818229',
'8013819443',
'8013821029',
'8013821030',
'8013823575',
'8013823592',
'8013823598',
'8013823601',
'8013823604',
'8013823605',
'8013823606',
'8013823608',
'8013823609',
'8013823610',
'8013823611',
'8013823612',
'8013823613',
'8013823614',
'8013823616',
'8013823617',
'8013823618',
'8013823620',
'8013823622',
'8013823623',
'8013823624',
'8013823625',
'8013823626',
'8013823627',
'8013823628',
'8013823629',
'8013823630',
'8013823631',
'8013823632',
'8013823633',
'8013823634',
'8013823635',
'8013823636',
'8013823637',
'8013823638',
'8013823639',
'8013823640',
'8013823641',
'8013823642',
'8013823643',
'8013823644',
'8013823645',
'8013823647',
'8013823648',
'8013823649',
'8013823650',
'8013823651',
'8013823653',
'8013823654',
'8013823655',
'8013823656',
'8013823657',
'8013823658',
'8013823659',
'8013823660',
'8013823661',
'8013823662',
'8013823663',
'8013823664',
'8013823665',
'8013823666',
'8013823667',
'8013823668',
'8013823669',
'8013823670',
'8013823671',
'8013823672',
'8013823673',
'8013823674',
'8013823675',
'8013823676',
'8013823677',
'8013823678',
'8013823679',
'8013823680',
'8013823681',
'8013823682',
'8013823683',
'8013823684',
'8013823685',
'8013823686',
'8013823687',
'8013823689',
'8013823690',
'8013823691',
'8013823692',
'8013823693',
'8013823694',
'8013823695',
'8013823696',
'8013823697',
'8013823698',
'8013823699',
'8013823700',
'8013823701',
'8013823702',
'8013823703',
'8013823704',
'8013823705',
'8013823706',
'8013823707',
'8013823708',
'8013823709',
'8013823710',
'8013823711',
'8013823712',
'8013823713',
'8013823714',
'8013823715',
'8013823716',
'8013823717',
'8013823718',
'8013823719',
'8013823720',
'8013823721',
'8013823722',
'8013823723',
'8013823724',
'8013823725',
'8013823726',
'8013823727',
'8013823728',
'8013823729',
'8013823730',
'8013823731',
'8013823732',
'8013823733',
'8013823734',
'8013823735',
'8013823736',
'8013823737',
'8013823738',
'8013823739',
'8013823740',
'8013823741',
'8013823742',
'8013823743',
'8013823744',
'8013823745',
'8013823746',
'8013823747',
'8013823748',
'8013823749',
'8013823750',
'8013823751',
'8013823752',
'8013823753',
'8013823754',
'8013823755',
'8013823756',
'8013823757',
'8013823758',
'8013823759',
'8013823760',
'8013823761',
'8013823762',
'8013823763',
'8013823764',
'8013823765',
'8013823766',
'8013823767',
'8013823768',
'8013823769',
'8013823770',
'8013823771',
'8013823772',
'8013823773',
'8013823774',
'8013823775',
'8013823776',
'8013823777',
'8013823778',
'8013823779',
'8013823780',
'8013823781',
'8013823782',
'8013823783',
'8013823784',
'8013823785',
'8013823786',
'8013823787',
'8013823788',
'8013823789',
'8013823790',
'8013823791',
'8013823792',
'8013823793',
'8013823794',
'8013823795',
'8013823797',
'8013823798',
'8013823799',
'8013823800',
'8013823802',
'8013823803',
'8013823804',
'8013823805',
'8013823806',
'8013823807',
'8013823808',
'8013823809',
'8013823810',
'8013823811',
'8013823812',
'8013823813',
'8013823814',
'8013823815',
'8013823816',
'8013823817',
'8013823818',
'8013823819',
'8013823820',
'8013823821',
'8013823822',
'8013823823',
'8013823824',
'8013823825',
'8013823826',
'8013823827',
'8013823828',
'8013823829',
'8013823830',
'8013823831',
'8013823832',
'8013823833',
'8013823834',
'8013823835',
'8013823836',
'8013823837',
'8013823838',
'8013823839',
'8013823840',
'8013823841',
'8013823842',
'8013823843',
'8013823844',
'8013823845',
'8013823846',
'8013823847',
'8013823848',
'8013823849',
'8013823850',
'8013823851',
'8013823852',
'8013823853',
'8013823854',
'8013823855',
'8013823857',
'8013823858',
'8013823859',
'8013823860',
'8013823861',
'8013823862',
'8013823864',
'8013823865',
'8013823866',
'8013823867',
'8013823868',
'8013823869',
'8013823870',
'8013823871',
'8013823872',
'8013823873',
'8013823874',
'8013823875',
'8013823876',
'8013823877',
'8013823879',
'8013823880',
'8013823881',
'8013823882',
'8013823883',
'8013823884',
'8013832988',
'8013832989',
'8013832991',
'8013834531',
'8013834532',
'8013834533',
'8013834534',
'8013834537',
'8013834540',
'8013834543',
'8013834544',
'8013834545',
'8013834546',
'8013834547',
'8013834548',
'8013834549',
'8013834551',
'8013834552',
'8013834553',
'8013834554',
'8013834555',
'8013834556',
'8013834557',
'8013834558',
'8013834559',
'8013834560',
'8013834561',
'8013834562',
'8013834563',
'8013834565',
'8013834566',
'8013834567',
'8013834568',
'8013834569',
'8013834570',
'8013834571',
'8013834572',
'8013834573',
'8013834574',
'8013834575',
'8013834576',
'8013834577',
'8013834578',
'8013834579',
'8013834580',
'8013834581',
'8013834582',
'8013834583',
'8013834584',
'8013834585',
'8013834586',
'8013834587',
'8013834588',
'8013834589',
'8013834590',
'8013834592',
'8013834593',
'8013834594',
'8013834595',
'8013834597',
'8013834598',
'8013834599',
'8013834601',
'8013834602',
'8013834603',
'8013834604',
'8013834605',
'8013834606',
'8013834607',
'8013834608',
'8013834609',
'8013834610',
'8013834611',
'8013834612',
'8013834613',
'8013834615',
'8013834616',
'8013834619',
'8013834620',
'8013834621',
'8013834622',
'8013834623',
'8013834624',
'8013834625',
'8013834626',
'8013834627',
'8013834628',
'8013834629',
'8013834630',
'8013834631',
'8013834632',
'8013834633',
'8013834634',
'8013834635',
'8013834636',
'8013834637',
'8013834638',
'8013834639',
'8013834640',
'8013834641',
'8013834642',
'8013834643',
'8013834644',
'8013834645',
'8013834646',
'8013834647',
'8013834648',
'8013834650',
'8013834651',
'8013834652',
'8013834653',
'8013834654',
'8013834655',
'8013834656',
'8013834657',
'8013834658',
'8013834659',
'8013834660',
'8013834661',
'8013834662',
'8013834663',
'8013834664',
'8013834665',
'8013834666',
'8013834667',
'8013834668',
'8013834669',
'8013834670',
'8013834671',
'8013834672',
'8013834673',
'8013834674',
'8013834675',
'8013834676',
'8013834677',
'8013834678',
'8013834679',
'8013834680',
'8013834681',
'8013834682',
'8013834683',
'8013834684',
'8013834685',
'8013834686',
'8013834687',
'8013834688',
'8013834689',
'8013834690',
'8013834691',
'8013834692',
'8013834693',
'8013834694',
'8013834695',
'8013834696',
'8013834697',
'8013834698',
'8013834699',
'8013834700',
'8013834701',
'8013834702',
'8013834703',
'8013834704',
'8013834705',
'8013834706',
'8013834707',
'8013834708',
'8013834709',
'8013834710',
'8013834711',
'8013834712',
'8013834713',
'8013834714',
'8013834715',
'8013834716',
'8013834717',
'8013834718',
'8013834719',
'8013834720',
'8013834721',
'8013834722',
'8013834723',
'8013834724',
'8013834725',
'8013834726',
'8013834727',
'8013834728',
'8013834729',
'8013834730',
'8013834731',
'8013834732',
'8013834733',
'8013834734',
'8013834735',
'8013834736',
'8013834737',
'8013834738',
'8013834739',
'8013834740',
'8013834741',
'8013834742',
'8013834743',
'8013834744',
'8013834745',
'8013834746',
'8013834747',
'8013834748',
'8013834749',
'8013834750',
'8013834751',
'8013834752',
'8013834753',
'8013834755',
'8013834756',
'8013834757',
'8013834758',
'8013834759',
'8013834760',
'8013834762',
'8013834763',
'8013834764',
'8013834765',
'8013834766',
'8013834767',
'8013834768',
'8013834769',
'8013834770',
'8013834771',
'8013834772',
'8013834773',
'8013834774',
'8013834775',
'8013834776',
'8013834777',
'8013834778',
'8013834779',
'8013834780',
'8013834781',
'8013834782',
'8013834783',
'8013834784',
'8013834785',
'8013834786',
'8013834787',
'8013834788',
'8013834789',
'8013834790',
'8013834791',
'8013834792',
'8013834793',
'8013834794',
'8013834795',
'8013834796',
'8013834797',
'8013834798',
'8013834799',
'8013835070',
'8013835071',
'8013848607',
'8013848608',
'8013848610',
'8013848611',
'8013848613',
'8013848614',
'8013848615',
'8013848616',
'8013848617',
'8013848618',
'8013848619',
'8013848620',
'8013848621',
'8013848622',
'8013848624',
'8013848625',
'8013848626',
'8013848627',
'8013848628',
'8013848629',
'8013848630',
'8013848631',
'8013848632',
'8013848633',
'8013848634',
'8013848635',
'8013848636',
'8013848637',
'8013848638',
'8013848639',
'8013848640',
'8013848641',
'8013848642',
'8013848643',
'8013848644',
'8013848645',
'8013848646',
'8013848647',
'8013848648',
'8013848649',
'8013848650',
'8013848651',
'8013848652',
'8013848653',
'8013848654',
'8013848655',
'8013848656',
'8013848657',
'8013848658',
'8013848659',
'8013848660',
'8013848661',
'8013848662',
'8013848664',
'8013848665',
'8013848666',
'8013848667',
'8013848668',
'8013848669',
'8013848670',
'8013848671',
'8013848672',
'8013848673',
'8013848674',
'8013848675',
'8013848676',
'8013848677',
'8013848678',
'8013848679',
'8013848680',
'8013848681',
'8013848682',
'8013848683',
'8013848684',
'8013848685',
'8013848686',
'8013851366',
'8013851369',
'8013851370',
'8013851372',
'8013851373',
'8013851374',
'8013851375',
'8013859728',
'8013859729',
'8013859730',
'8013859731',
'8013859732',
'8013859733',
'8013859734',
'8013859735',
'8013859736',
'8013859737',
'8013859738',
'8013859739',
'8013859740',
'8013859741',
'8013859742',
'8013859743',
'8013859744',
'8013859745',
'8013859746',
'8013859747',
'8013859748',
'8013859749',
'8013859750',
'8013859751',
'8013859752',
'8013859753',
'8013859754',
'8013859755',
'8013859756',
'8013859757',
'8013859758',
'8013859759',
'8013859760',
'8013859761',
'8013859762',
'8013859763',
'8013859764',
'8013859765',
'8013859766',
'8013859767',
'8013859768',
'8013859769',
'8013859770',
'8013859771',
'8013859772',
'8013859773',
'8013859774',
'8013859775',
'8013859776',
'8013859777',
'8013859778',
'8013859779',
'8013859780',
'8013859781',
'8013859782',
'8013859783',
'8013859784',
'8013859785',
'8013859786',
'8013859787',
'8013859788',
'8013859789',
'8013859790',
'8013859791',
'8013859792',
'8013859794',
'8013859795',
'8013859796',
'8013859797',
'8013859798',
'8013859799',
'8013859800',
'8013859801',
'8013859802',
'8013859803',
'8013859804',
'8013861030',
'8013861031',
'8013861032',
'8013861033',
'8013861036',
'8013861037',
'8013861412',
'8013861413',
'8013861414',
'8013861415',
'8013861417',
'8013861863',
'8013861864',
'8013861865',
'8013862755',
'8013862756',
'8013869233',
'8013894970',
'8013894968',
'8013894969',
'8013894967');
