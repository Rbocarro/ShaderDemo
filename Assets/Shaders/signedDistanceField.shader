Shader "Unlit/signedDistanceField"
{
    Properties
    {

    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct Meshdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

     
            float4 _MainTex_ST;

            v2f vert (Meshdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = (v.uv*2)-1;

                return o;
            }

            float4 frag (v2f i) : SV_Target
            {

                float dist=length(i.uv.x)-0.5;
                return step(0,dist);

                //return float4(dist.xxx,0);
                //return float4(i.uv,0,0);
            }
            ENDCG
        }
    }
}
