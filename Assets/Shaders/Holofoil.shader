Shader "Unlit/Holofoil"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _HolofoilTex ("Holofoil Texture", 2D) = "white" {}
        _Scale("Plasma Scale",Range(0.1,5.0))=1
        _Intensity("Foil intensity",Range(0.0,2.0))=1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment fraga

            #include "UnityCG.cginc"

            sampler2D _MainTex;
            float4 _MainTex_ST;

            sampler2D _HolofoilTex;
            float _Scale,_Intensity;

            struct MeshData
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                float3 viewDir:TEXCOORD1;
            };



            float3 Plasma(float2 uv)
            {
                uv = uv * _Scale - _Scale / 2;
                float time =0;
                float w1 = sin(uv.x + time);
                float w2 = sin(uv.y + time);
                float w3 = sin(uv.x + uv.y + time);         
                float r = sin(sqrt(uv.x * uv.x + uv.y * uv.y) + time);
                float finalValue = w1 + w2 + w3 + r;
                float c1=sin(finalValue*UNITY_PI);
                float c2=cos(finalValue*UNITY_PI);
                float c3=sin(finalValue);
                return float3(c1,c2,c3);
                //float3 finalWave =  float3(sin(finalValue *     UNITY_PI),cos(finalValue* UNITY_PI), sin(finalValue ));
               // return finalWave * 0.5 + 0.5;     
           }

            v2f vert (MeshData v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.viewDir=WorldSpaceViewDir(v.vertex);
                return o;
            }

            fixed4 fraga (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                fixed4 foil=tex2D(_HolofoilTex, i.uv);
                
                float2 newUV=i.viewDir.xy+foil.rg;
                float3 plasma=Plasma(newUV)*_Intensity;
                return fixed4(col.rgb+col.rgb*plasma.rgb,1);
            }
            ENDCG
        }
    }
}
