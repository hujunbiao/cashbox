package info.scry.wallet;

public class Native {
    //������
    private class ChainType {
        public static final int BTC = 1;
        public static final int BTC_TEST = 2;
        public static final int ETH = 3;
        public static final int ETH_TEST = 4;
        public static final int EEE = 5;
        public static final int EEE_TEST = 6;
    }

    //ͨ����Ϣ
    private class Message {
        public int err;         //StatusCode״̬��
        public byte[] data;
    }

    //ͨ����Ϣ ״̬��
    private class StatusCode {
        public static final int OK = 200;                           //����
        public static final int FAIL_TO_GENERATE_MNEMONIC = 100;    //�������Ǵ�ʧ��
        public static final int PWD_IS_WRONG = 101;                 //�������
        public static final int FAIL_TO_RESET_PWD = 102;            //��������ʧ��
        public static final int GAS_NOT_ENOUGH = 103;               //GAS�Ѳ���
        public static final int BROADCAST_OK = 104;                 //�㲥�����ɹ�
        public static final int BROADCAST_FAILURE = 105;            //�㲥����ʧ��
    }

    static {
        System.loadLibrary("wallet");
    }
    //todo mnemonic byte[]

    /*------------------------------------------���Ǵ�------------------------------------------*/
    //�������Ǵʣ�������ѡ��
    //���أ�String       "{ err:" + err +","+"data:"+ ���Ǵ�byte[]+" }"
    public static native String mnemonicGenerate(int count);

    //�������Ǵ� �� �������Ǵ� + ���룬
    //���أ�String       "{ err:" + err +","+"data:"+���ܺ�����Ǵ� byte[]+" }"
    public static native String mnemonicEncode(byte[] mn, byte[] pwd);

    //�������Ǵ� �� ���� ���ܺ�����Ǵ��ִ� + ����
    //���أ�String        "{ err:" + err +","+"data:"+ ���Ǵ� byte[]+" }"
    public static native String mnemonicDecode(byte[] en, byte[] pwd);

    //�������룬 ���� ���ܺ�����Ǵ��ִ� + ������ + �����룬
    //���أ�String        "{ err:" + err +","+"data:"+ ���Ǵ� byte[] +" }"
    public static native String mnemonicResetPwd(byte[] en, byte[] oldPwd, byte[] newPwd);

    /*------------------------------------------�����------------------------------------------*/
    //��ȡ����ַ������������
    //���أ�����ַString  "{ err:" + err +","+"data:"+ byte[]+" }"
    //data˵���� "[{ chainType:0,address:0x123456789},{ chainType:1,address:0x987654321}]" ת�� byte[]
    public static native String[] chainGetAddress(byte[] mn, int[] chainType);

    /* //��ȡ���׼�¼�� ���������ͣ� ָ����ַ ָ������
    //���أ������׼�¼��
    public static native String chainGetTxHistory(int chainType, String targetAddress, int fromNum, int toNum);*/

    /*------------------------------------------�������------------------------------------------*/
    //ETH ����ƴװ��   ���أ�δǩ���Ľ��� String��
    //nonce��¼λ�ã�����
    public static native byte[] ethTxMakeETHRawTx(byte[] encodeMneByte, String pwd, String fromAddress, String toAddress,
                                                  String value, String backupMsg, String gasLimit, String gasPrice);

    //ERC20 ����ƴװ��    ���أ�δǩ���Ľ��� String
    // nonce��¼λ�ã�����
    public static native byte[] ethTxMakeERC20RawTx(byte[] encodeMneByte, String pwd, String fromAddress, String contractAddress,
                                                    String toAddress, String value, String backupMsg, String gasLimit, String gasPrice);

    //���������ȿ��ǣ�ʵ��spv�Ŀ⴦����   �ܸ������ȡutxo,���������ַѡ��,�����
    public static native byte[] btcTxMakeBTCRawTx(String[] from, String[] to, String value);

    //EEE nonce��ȡ
    public static native String eeeGetTxNonce();

    public static native byte[] eeeTxMakeRawTx(String from, String to, String nonce, String value, String backupMsg);

    //��ȡǩ����Ľ�����Ϣ������������
    //���أ�ǩ����Ľ��� byte[]
    public static native byte[] ethTxSignTx(String rawTx, byte[] encodeMne, String pwd);

    public static native byte[] eeeTxSignTx(String rawTx, byte[] encodeMne, String pwd);

    public static native byte[] btcTxSignTx(String rawTx, byte[] encodeMne, String pwd);

    //�㲥���ף�����������
    //���أ��㲥�ɹ�1�� �㲥ʧ��0
    public static native boolean ethTxBroascastTx([]byte signedTx);

    public static native boolean btcTxBroascastTx([]byte signedTx);

    public static native boolean eeeTxBroascastTx([]byte signedTx);

}

/*
    fixd ���Ǵʶ�������һ�����ʿ������ɶ�������ַ��eth,btc,eee��

    fixd ǩ����Ǯ���ж�������

    fixd �����ܣ�ȡ����Ǯ����صĵ�ַ���ף�

    fixd ���ɽ��ף�noǩ��������������������

         ��ui��������

         ���׼�¼���ش�ţ������ϼ�¼λ�ã���

         Ǯ���б������Դ��

         �������ݿ⣺    ���汾�ؽ��׼�¼ + Ǯ���б�������ɾ����Ǯ�������赱ǰǮ����Ǯ������ַ�����ϴ�����Ϣ��
         ����flutter���棬����
*/